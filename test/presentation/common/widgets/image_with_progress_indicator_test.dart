import 'dart:async';
import 'dart:io';

import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _ControlledImageTransport transport;

  setUp(() {
    transport = _ControlledImageTransport();
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  });

  tearDown(() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  });

  testWidgets('retries a failed network image once after evicting the provider',
      (
    tester,
  ) async {
    await _withControlledNetworkClient(transport, () async {
      const url = 'https://tenant.test/transient.png';
      transport.enqueue(url, _ImageResponse.failure());
      final retrySuccess = _ImageResponse.success();
      transport.enqueue(url, retrySuccess);

      await tester.pumpWidget(_imageUnderTest(url));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsNothing);

      await _pumpUntilRequestCount(tester, transport, url, 2);
      await retrySuccess.completed;
      await _pumpUntilAbsent(tester, find.byType(CircularProgressIndicator));

      expect(transport.requestCountFor(url), 2);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.error_outline), findsNothing);
    });
  });

  testWidgets('settles in the existing error UI after one failed retry', (
    tester,
  ) async {
    await _withControlledNetworkClient(transport, () async {
      const url = 'https://tenant.test/unavailable.png';
      transport.enqueue(url, _ImageResponse.failure());
      transport.enqueue(url, _ImageResponse.failure());

      await tester.pumpWidget(_imageUnderTest(url));
      await _pumpUntilRequestCount(tester, transport, url, 2);
      await tester.pump();

      expect(transport.requestCountFor(url), 2);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      await tester.pump();
      expect(transport.requestCountFor(url), 2);
    });
  });

  testWidgets('does not apply a stale retry to a replacement image', (
    tester,
  ) async {
    await _withControlledNetworkClient(transport, () async {
      const firstUrl = 'https://tenant.test/first.png';
      const secondUrl = 'https://tenant.test/second.png';
      transport.enqueue(firstUrl, _ImageResponse.failure());
      transport.enqueue(secondUrl, _ImageResponse.failure());
      final secondRetrySuccess = _ImageResponse.success();
      transport.enqueue(secondUrl, secondRetrySuccess);

      await tester.pumpWidget(_imageUnderTest(firstUrl));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(transport.requestCountFor(firstUrl), 1);

      await tester.pumpWidget(_imageUnderTest(secondUrl));
      await _pumpUntilRequestCount(tester, transport, secondUrl, 2);
      await secondRetrySuccess.completed;
      await _pumpUntilAbsent(tester, find.byType(CircularProgressIndicator));

      expect(transport.requestCountFor(firstUrl), 1);
      expect(transport.requestCountFor(secondUrl), 2);
      expect(find.byIcon(Icons.error_outline), findsNothing);
    });
  });
}

Future<void> _pumpUntilAbsent(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 20; attempt++) {
    await tester.pump();
    if (finder.evaluate().isEmpty) {
      return;
    }
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  }

  fail(
    'Expected ${finder.describeMatch(Plurality.many)} to disappear after image load',
  );
}

Future<void> _pumpUntilRequestCount(
  WidgetTester tester,
  _ControlledImageTransport transport,
  String url,
  int expectedCount,
) async {
  for (var attempt = 0; attempt < 20; attempt++) {
    await tester.pump();
    if (transport.requestCountFor(url) >= expectedCount) {
      return;
    }
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  }

  fail(
    'Expected at least $expectedCount image requests for $url, got ${transport.requestCountFor(url)}',
  );
}

Future<void> _withControlledNetworkClient(
  _ControlledImageTransport transport,
  Future<void> Function() body,
) async {
  debugNetworkImageHttpClientProvider = () => _ControlledHttpClient(transport);
  try {
    await body();
  } finally {
    debugNetworkImageHttpClientProvider = null;
  }
}

Widget _imageUnderTest(String url) {
  return MaterialApp(
    home: Scaffold(
      body: ImageWithProgressIndicator(
        uri: Uri.parse(url),
      ),
    ),
  );
}

class _ControlledHttpClient implements HttpClient {
  _ControlledHttpClient(this.transport);

  final _ControlledImageTransport transport;
  bool _autoUncompress = true;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async =>
      _ControlledHttpClientRequest(transport.next(url));

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async =>
      _ControlledHttpClientRequest(transport.next(url));

  @override
  bool get autoUncompress => _autoUncompress;

  @override
  set autoUncompress(bool value) => _autoUncompress = value;

  @override
  Object? noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ControlledHttpClientRequest implements HttpClientRequest {
  _ControlledHttpClientRequest(this.response);

  final _ImageResponse response;

  @override
  Future<HttpClientResponse> close() => response.future;

  @override
  Object? noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ControlledImageTransport {
  final Map<String, List<_ImageResponse>> _responses =
      <String, List<_ImageResponse>>{};
  final Map<String, int> _requestCounts = <String, int>{};

  void enqueue(String url, _ImageResponse response) {
    _responses.putIfAbsent(url, () => <_ImageResponse>[]).add(response);
  }

  _ImageResponse next(Uri url) {
    final key = url.toString();
    _requestCounts[key] = requestCountFor(key) + 1;
    final responses = _responses[key];
    if (responses == null || responses.isEmpty) {
      throw StateError('Unexpected image request for $key');
    }

    return responses.removeAt(0);
  }

  int requestCountFor(String url) => _requestCounts[url] ?? 0;
}

class _ImageResponse extends Stream<List<int>> implements HttpClientResponse {
  _ImageResponse._(
    this.statusCode,
    this._stream,
    this._contentLength,
    this.completed,
  );

  factory _ImageResponse.failure() => _ImageResponse._(
        HttpStatus.internalServerError,
        Stream<List<int>>.empty(),
        0,
        Future<void>.value(),
      );

  factory _ImageResponse.success() {
    final controller = StreamController<List<int>>();
    controller.onListen = () {
      controller
        ..add(_transparentPng)
        ..close();
    };

    return _ImageResponse._(
      HttpStatus.ok,
      controller.stream,
      _transparentPng.length,
      controller.done,
    );
  }

  @override
  final int statusCode;
  final Stream<List<int>> _stream;
  final int _contentLength;
  final Future<void> completed;

  Future<HttpClientResponse> get future async => this;

  @override
  int get contentLength => _contentLength;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Object? noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const List<int> _transparentPng = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
];
