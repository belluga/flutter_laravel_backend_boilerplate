import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';

class SliverPhotoGallery extends StatelessWidget {
  final List<Uri?> mediaItems;

  const SliverPhotoGallery({super.key, required this.mediaItems});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}
