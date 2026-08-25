import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';
import 'package:flutter/material.dart';

class CourseMediaGallery extends StatelessWidget {
  const CourseMediaGallery({
    super.key,
    required this.mediaItems,
    required this.onViewAll,
  });

  final List<Uri?> mediaItems;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Galeria de fotos',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                ),
                onPressed: onViewAll,
                child: const Text('Ver todas'),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mediaItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return ImageWithProgressIndicator(uri: mediaItems[index]);
            },
          ),
        ),
      ],
    );
  }
}
