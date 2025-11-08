import 'package:flutter/material.dart';

class ImageWithProgressIndicator extends StatelessWidget {
  final Uri? uri;
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ImageWithProgressIndicator({
    super.key,
    required this.uri,
    this.width = 80,
    this.height = 80,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final Uri? _uri = uri;
    if (_uri == null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: const Icon(Icons.broken_image),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Image.network(
        _uri.toString(),
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator()),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            width: width,
            height: height,
            child: Icon(Icons.error_outline,
                color: Theme.of(context).colorScheme.error),
          );
        },
      ),
    );
  }
}
