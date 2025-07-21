import 'package:flutter/material.dart';
import 'package:unifast_portal/application/configurations/assets_constants.dart';
import 'package:unifast_portal/domain/courses/thumb_model.dart';

class ImageWithProgressIndicator extends StatelessWidget {
  final ThumbModel? thumb;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ImageWithProgressIndicator({
    super.key,
    this.thumb,
    this.width = 80,
    this.height = 80,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = thumb?.thumbUri.toString();

    // Use a placeholder if the thumb or its URI is null.
    if (imageUrl == null) {
      return _buildPlaceholder(context);
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child; // image is loaded
          }
          // Display a progress indicator while loading
          return SizedBox(
            width: width,
            height: height,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          // On error, display the placeholder.
          // You could also log the error to Sentry here if needed.
          return _buildPlaceholder(context);
        },
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(AssetsConstants.courses.placeholder),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
