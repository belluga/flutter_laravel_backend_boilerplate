import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';

class GalleryBottomModal extends StatelessWidget {
  final List<Uri?> mediaItems;

  const GalleryBottomModal({super.key, required this.mediaItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MasonryGridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: mediaItems.length,
          itemBuilder: (context, index) {
            return ImageWithProgressIndicator(uri: mediaItems[index]);
          },
        ),
      ],
    );
  }
}
