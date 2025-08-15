import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unifast_portal/presentation/screens/lms/screens/course_screen/controllers/course_screen_controller.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:unifast_portal/presentation/view_model/time_label.dart';
import 'package:video_player/video_player.dart';

class PlayBar extends StatefulWidget {
  const PlayBar({super.key});

  @override
  State<PlayBar> createState() => _PlayBarState();
}

class _PlayBarState extends State<PlayBar> {
  @override
  Widget build(BuildContext context) {
    final _controller = GetIt.I.get<CourseScreenController>();

    return StreamValueBuilder<Duration?>(
      streamValue: _controller.contentVideoPlayerController.positionStreamValue,
      builder: (context, position) {
        final _position = TimeLabel(duration: position ?? Duration.zero);
        final _duration = TimeLabel(
            duration: _controller.contentVideoPlayerController
                .videoPlayerController.value.duration);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _position.label,
              style: TextTheme.of(context).labelSmall,
            ),
            SizedBox(width: 8),
            Expanded(
              child: VideoProgressIndicator(
                padding: EdgeInsets.symmetric(vertical: 16),
                _controller.contentVideoPlayerController.videoPlayerController,
                allowScrubbing: true,
              ),
            ),
            SizedBox(width: 8),
            Text(
              _duration.label,
              style: TextTheme.of(context).labelSmall,
            ),
          ],
        );
      },
    );
  }
}
