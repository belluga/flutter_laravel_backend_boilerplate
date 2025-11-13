import 'package:belluga_boilerplate/application/extensions/compute_on_color.dart';
import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_category_model.dart';

class CategoryChip extends StatelessWidget {
  final CourseCategoryModel category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final Color _color = category.color.value.computeIconColor(context);

    return Chip(
      avatar: Icon(
        Icons.category_outlined,
        size: 16,
        color: _color,
      ),
      visualDensity: VisualDensity.compact,
      label: Text(
        category.name.value,
        style: TextTheme.of(context).labelSmall?.copyWith(
              color: _color,
            ),
      ),
      backgroundColor: category.color.value,
    );
  }
}
