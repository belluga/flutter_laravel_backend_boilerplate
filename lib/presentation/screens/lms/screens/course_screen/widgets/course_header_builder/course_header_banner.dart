import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unifast_portal/domain/courses/course_category_model.dart';
import 'package:unifast_portal/domain/courses/course_item_model.dart';
import 'package:unifast_portal/presentation/common/widgets/image_with_progress_indicator.dart';
import 'package:unifast_portal/presentation/screens/lms/widgets/category_chip.dart';

class CourseHeaderBanner extends StatelessWidget {
  final CourseItemModel courseItemModel;

  const CourseHeaderBanner({super.key, required this.courseItemModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          ClipRRect(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ImageWithProgressIndicator(
                  thumb: courseItemModel.thumb,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(color: Colors.transparent),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceDim.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SafeArea(
                  bottom: false,
                  child: Row(
                    children: [BackButton()],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            courseItemModel.title.value,
                            maxLines: 2,
                            style: TextTheme.of(context).headlineSmall,
                          ),
                          Builder(
                            builder: (context) {
                              final List<CourseCategoryModel>? _categories =
                                  courseItemModel.categories;

                              if (_categories == null || _categories.isEmpty) {
                                return SizedBox.shrink();
                              }

                              return Wrap(
                                spacing: 8.0,
                                alignment: WrapAlignment.end,
                                children: _categories
                                    .map(
                                      (category) =>
                                          CategoryChip(category: category),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
