import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_item_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/course_screen/widgets/content_video_player/content_video_player.dart';

class CourseHeaderVideo extends StatefulWidget {
  final CourseItemModel courseItemModel;

  const CourseHeaderVideo({super.key, required this.courseItemModel});

  @override
  State<CourseHeaderVideo> createState() => _CourseHeaderVideoState();
}

class _CourseHeaderVideoState extends State<CourseHeaderVideo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: ContentVideoPlayer(courseItemModel: widget.courseItemModel),
    );
  }
}
