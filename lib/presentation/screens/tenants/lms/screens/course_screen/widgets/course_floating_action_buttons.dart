import 'package:belluga_boilerplate/application/fonts/belluga_icons.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/controllers/course_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/widgets/content_video_player/enums/tab_content_type.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class CourseFloatingActionButtons extends StatefulWidget {

  final void Function({NoteModel? noteModel}) onPressed;

  const CourseFloatingActionButtons({super.key, required this.onPressed});

  @override
  State<CourseFloatingActionButtons> createState() => _CourseFloatingActionButtonsState();
}

class _CourseFloatingActionButtonsState extends State<CourseFloatingActionButtons> {
  final _controller = GetIt.I.get<CourseScreenController>();

  @override
  Widget build(BuildContext context) {
    return StreamValueBuilder<TabContentType>(
      streamValue: _controller.tabContentTypeStreamValue,
      onNullWidget: SizedBox.shrink(),
      builder: (context, tabContentType) {
        if (tabContentType != TabContentType.notes) {
          return SizedBox.shrink();
        }

        return FloatingActionButton(
          onPressed: widget.onPressed,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            BellugaIcons.sticky_note,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        );
      },
    );
  }
}
