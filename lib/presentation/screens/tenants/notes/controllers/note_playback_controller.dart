import 'dart:async';

import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/domain/notes/note_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/widgets/content_video_player/controller/content_video_player_controller.dart';
import 'package:video_player/video_player.dart';

class NotePlaybackController {
  NotePlaybackController();

  final ContentVideoPlayerController contentVideoController =
      ContentVideoPlayerController();

  bool get isInitialized => contentVideoController.isInitialized;
  VideoPlayerController get videoController =>
      contentVideoController.videoPlayerController;

  Future<void> initPlayer({
    required CourseItemModel courseItem,
    required NoteModel note,
  }) async {
    await contentVideoController.clearLesson();
    await contentVideoController.changeLesson(courseItem);
    final position = note.position.value;
    if (position != null) {
      final seekTo = position > const Duration(seconds: 2)
          ? position - const Duration(seconds: 2)
          : Duration.zero;
      await contentVideoController.videoPlayerController.seekTo(seekTo);
    }
    await contentVideoController.videoPlayerController.play();
  }

  Future<void> dispose() async {
    await contentVideoController.clearLesson();
  }
}
