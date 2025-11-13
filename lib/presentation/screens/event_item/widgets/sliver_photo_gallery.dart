import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';

class SliverPhotoGallery extends StatelessWidget {
  final List<Uri?> mediaItems;

  const SliverPhotoGallery({super.key, required this.mediaItems});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: MasonryGridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mediaItems.length,
        itemBuilder: (context, index) {
          return ImageWithProgressIndicator(uri: mediaItems[index]);
        },
      ),
    );
  }
}
