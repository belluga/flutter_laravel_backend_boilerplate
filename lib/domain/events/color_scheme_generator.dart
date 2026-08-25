import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Utility responsible for generating a [ColorScheme] from a remote image.
class ColorSchemeGenerator {
  static Future<ColorScheme> fromImageUri(Uri? imageUri) async {
    final fallbackScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

    if (imageUri == null) {
      return fallbackScheme;
    }

    try {
      final quantizerResult = await _extractColorsFromImageProvider(
        NetworkImage(imageUri.toString()),
      );

      final colorToCount = quantizerResult.colorToCount.map(
        (key, value) => MapEntry<int, int>(_getArgbFromAbgr(key), value),
      );

      final prominentColors = Score.score(
        colorToCount,
        desired: 3,
        filter: true,
      );

      if (prominentColors.isEmpty) {
        return fallbackScheme;
      }

      final primarySeed = prominentColors[0];
      final primaryHct = Hct.fromInt(primarySeed);
      final primaryTones = TonalPalette.of(primaryHct.hue, primaryHct.chroma);
      return ColorScheme.fromSeed(seedColor: Color(primaryTones.get(50)));
    } catch (_) {
      return fallbackScheme;
    }
  }

  static Future<QuantizerResult> _extractColorsFromImageProvider(
      ImageProvider imageProvider) async {
    final ui.Image scaledImage = await _imageProviderToScaled(imageProvider);
    final ByteData? imageBytes = await scaledImage.toByteData();

    final QuantizerResult quantizerResult = await QuantizerCelebi().quantize(
      imageBytes!.buffer.asUint32List(),
      128,
      returnInputPixelToClusterPixel: true,
    );
    return quantizerResult;
  }

  static Future<ui.Image> _imageProviderToScaled(
      ImageProvider imageProvider) async {
    const double maxDimension = 112.0;
    final ImageStream stream =
        imageProvider.resolve(const ImageConfiguration());
    final Completer<ui.Image> imageCompleter = Completer<ui.Image>();
    late ImageStreamListener listener;
    late ui.Image scaledImage;
    Timer? loadFailureTimeout;

    listener = ImageStreamListener((ImageInfo info, bool sync) async {
      loadFailureTimeout?.cancel();
      stream.removeListener(listener);
      final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(pictureRecorder);
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTRB(
          0,
          0,
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ),
        image: info.image,
        filterQuality: FilterQuality.none,
      );
      final ui.Picture picture = pictureRecorder.endRecording();
      scaledImage = await picture.toImage(
        info.image.width.clamp(1, maxDimension.toInt()),
        info.image.height.clamp(1, maxDimension.toInt()),
      );
      imageCompleter.complete(info.image);
    }, onError: (Object exception, StackTrace? stackTrace) {
      stream.removeListener(listener);
      imageCompleter.completeError(exception, stackTrace);
    });

    loadFailureTimeout = Timer(const Duration(seconds: 5), () {
      stream.removeListener(listener);
      imageCompleter.completeError(
        TimeoutException('Timeout occurred trying to load image'),
      );
    });

    stream.addListener(listener);
    await imageCompleter.future;
    return scaledImage;
  }

  static int _getArgbFromAbgr(int abgr) {
    const int exceptRMask = 0xFF00FFFF;
    const int onlyRMask = ~exceptRMask;
    const int exceptBMask = 0xFFFFFF00;
    const int onlyBMask = ~exceptBMask;
    final int r = (abgr & onlyRMask) >> 16;
    final int b = abgr & onlyBMask;
    return (abgr & exceptRMask & exceptBMask) | (b << 16) | r;
  }
}
