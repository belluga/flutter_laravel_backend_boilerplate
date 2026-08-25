import 'package:belluga_boilerplate/application/extensions/color_shades.dart';
import 'package:flutter/material.dart';

class ColorChoice extends StatelessWidget {
  final Color color;
  final VoidCallback? onTap;
  final bool isSelected;

  const ColorChoice({
    super.key,
    required this.color,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? Border.all(color: color.darken(0.4), width: 3)
                  : Border.all(color: Colors.transparent),
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check,
              color: color.darken(0.4),
              size: 24,
            ),
        ],
      ),
    );
  }
}
