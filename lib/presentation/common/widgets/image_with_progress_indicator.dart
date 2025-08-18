import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/courses/thumb_model.dart';

class ImageWithProgressIndicator extends StatelessWidget {
  final ThumbModel? thumb;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ImageWithProgressIndicator({
    super.key,
    required this.thumb,
    this.width = 80,
    this.height = 80,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final ThumbModel? _thumbModel = thumb;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
          ),
          if (_thumbModel != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                image: DecorationImage(
                  image: Image.network(_thumbModel.thumbUri.toString()).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
