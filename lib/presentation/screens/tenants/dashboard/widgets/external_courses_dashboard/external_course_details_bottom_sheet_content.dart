import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/external_course/external_course_model.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/image_with_progress_indicator.dart';

class ExternalCourseDetailsBottomSheetContent extends StatelessWidget {
  final ExternalCourseModel course;
  final Function() onExternalLinkClick;

  const ExternalCourseDetailsBottomSheetContent({
    super.key,
    required this.course,
    required this.onExternalLinkClick,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ImageWithProgressIndicator(uri: course.thumb.thumbUri.value),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title.valueFormated,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  course.description.value,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: onExternalLinkClick,
                  icon: Icon(
                    Icons.open_in_new,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  label: const Text('Acessar o curso'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
