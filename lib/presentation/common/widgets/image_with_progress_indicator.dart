import 'package:flutter/material.dart';

class ImageWithProgressIndicator extends StatefulWidget {
  const ImageWithProgressIndicator({
    super.key,
    required this.uri,
    this.width = 80,
    this.height = 80,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final Uri? uri;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxFit fit;

  @override
  State<ImageWithProgressIndicator> createState() =>
      _ImageWithProgressIndicatorState();
}

class _ImageWithProgressIndicatorState
    extends State<ImageWithProgressIndicator> {
  bool _retryPending = false;
  bool _hasRetried = false;
  int _retryGeneration = 0;

  @override
  void didUpdateWidget(ImageWithProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.uri != widget.uri) {
      _retryGeneration++;
      _retryPending = false;
      _hasRetried = false;
    }
  }

  void _scheduleRetry(ImageProvider<Object> provider) {
    if (_hasRetried || _retryPending) {
      return;
    }

    _retryPending = true;
    final retryGeneration = _retryGeneration;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || retryGeneration != _retryGeneration) {
        return;
      }

      await provider.evict();
      if (!mounted || retryGeneration != _retryGeneration) {
        return;
      }

      setState(() {
        _retryPending = false;
        _hasRetried = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Uri? _uri = widget.uri;
    if (_uri == null) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
        ),
        child: const Icon(Icons.broken_image),
      );
    }

    final provider = NetworkImage(_uri.toString());

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
      child: Image(
        key: ValueKey<bool>(_hasRetried),
        image: provider,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Center(
              child: SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator()),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          if (!_hasRetried) {
            _scheduleRetry(provider);

            return SizedBox(
              width: widget.width,
              height: widget.height,
              child: const Center(
                child: SizedBox(
                    width: 20, height: 20, child: CircularProgressIndicator()),
              ),
            );
          }

          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: Icon(Icons.error_outline,
                color: Theme.of(context).colorScheme.error),
          );
        },
      ),
    );
  }
}
