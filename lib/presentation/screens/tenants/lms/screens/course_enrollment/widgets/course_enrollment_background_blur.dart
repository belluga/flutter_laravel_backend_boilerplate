import 'dart:ui';

import 'package:flutter/material.dart';

class CourseEnrollmentBackgroundBlur extends StatelessWidget {
  const CourseEnrollmentBackgroundBlur({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Container(color: Colors.black12);
    }

    return Positioned.fill(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
