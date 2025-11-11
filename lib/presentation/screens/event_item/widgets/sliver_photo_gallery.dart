import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:festou_app/domain/thumb/gallery_item_model.dart';
import 'package:festou_app/presentation/common/widgets/image_with_progress_indicator.dart';

class SliverPhotoGallery extends StatelessWidget {
  final List<GalleryItemModel> mediaItems;

  const SliverPhotoGallery({super.key, required this.mediaItems});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: MasonryGridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        physics: NeverScrollableScrollPhysics(),
        itemCount: mediaItems.length,
        itemBuilder: (context, index) {
          return ImageWithProgressIndicator(thumb: mediaItems[index]);
        },
      ),
    );
  }
}
