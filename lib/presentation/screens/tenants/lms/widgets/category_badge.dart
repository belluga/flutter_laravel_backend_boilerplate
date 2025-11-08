import 'package:belluga_boilerplate/application/extensions/compute_on_color.dart';
import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/courses/course_category_model.dart';

class CategoryBadge extends StatefulWidget {
  final CourseCategoryModel category;

  const CategoryBadge({super.key, required this.category});

  @override
  State<CategoryBadge> createState() => _CategoryBadgeState();
}

class _CategoryBadgeState extends State<CategoryBadge> {
  @override
  Widget build(BuildContext context) {
    final Color _color =
        widget.category.color.value;

    return CircleAvatar(
      backgroundColor: widget.category.color.value,
      radius: 16,
      child: Icon(
        Icons.category_outlined,
        size: 16,
        color: _color.computeIconColor(context),
      ),
    );
  }
}
