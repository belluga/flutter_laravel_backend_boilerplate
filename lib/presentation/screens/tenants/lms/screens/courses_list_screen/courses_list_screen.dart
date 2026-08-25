import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/courses_list_screen/controllers/courses_list_screen_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/lms/screens/courses_list_screen/widgets/my_course_card_on_list.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class CoursesListScreen extends StatefulWidget {
  const CoursesListScreen({super.key});

  @override
  State<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends State<CoursesListScreen> {
  final _controller = GetIt.I.get<CoursesListScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meus Cursos",
          maxLines: 2,
          style: TextTheme.of(context).titleMedium,
        ),
        automaticallyImplyLeading: true,
      ),
      body: StreamValueBuilder<List<CourseBaseModel>>(
        streamValue: _controller.courseStreamValue,
        onNullWidget: SizedBox.shrink(),
        builder: (context, courses) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(courses.length, (index) {
                    return MyCourseCardOnList(course: courses[index]);
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
