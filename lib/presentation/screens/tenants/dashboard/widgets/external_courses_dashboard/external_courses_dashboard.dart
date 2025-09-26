import 'package:belluga_boilerplate/presentation/widgets/dashboard_widget_animated.dart';
import 'package:flutter/material.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/dashboard_items_summary.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/controllers/external_course_dashboard_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/view_models/external_courses_summary.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/widgets/external_courses_dashboard/external_course_card.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';

class ExternalCoursesDashboard extends StatefulWidget {
  const ExternalCoursesDashboard({super.key});

  @override
  State<ExternalCoursesDashboard> createState() =>
      _ExternalCoursesDashboardState();
}

class _ExternalCoursesDashboardState extends State<ExternalCoursesDashboard> {
  late ExternalCourseDashboardController _controller;

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton<ExternalCourseDashboardController>(
      ExternalCourseDashboardController(),
    );
    _controller = GetIt.I.get<ExternalCourseDashboardController>();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return StreamValueBuilder<ExternalCoursesSummary>(
      streamValue: _controller.externalCoursesSummaryStreamValue,
      onNullWidget: SizedBox.shrink(),
      builder: (context, courseSummary) {
        
        return DashboardWidgetAnimated(
          isVisible: courseSummary.items.isNotEmpty,
          child: DashboardItemsSummary(
            title: "Cursos Externos",
            itemsPerRow: 1.1,
            itemsBuilder: _itemsBuilder,
          ),
        );
      },
    );
  }

  Widget? _itemsBuilder(int index) {
    final _externalCoursesSummary =
        _controller.externalCoursesSummaryStreamValue.value!;

    if (index >= _externalCoursesSummary.items.length) {
      return null;
    }

    final _course = _externalCoursesSummary.items[index];

    return ExternalCourseCard(course: _course);
  }

  @override
  void dispose() {
    GetIt.I.unregister<ExternalCourseDashboardController>();
    super.dispose();
  }
}
