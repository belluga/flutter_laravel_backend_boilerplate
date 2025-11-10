import 'package:auto_route/auto_route.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/common/widgets/tenant_bottom_navigation.dart';
import 'package:belluga_boilerplate/presentation/widgets/sliver_dashboard_widget_animated.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/learning_experience/course_base_model.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/main_logo/main_logo.dart';
import 'package:belluga_boilerplate/presentation/common/widgets/profile_action_button/profile_action_button.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/controllers/my_courses_dashboard_controller.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/widgets/next_events_dashboard/next_events_dashboard.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/widgets/external_courses_dashboard/external_courses_dashboard.dart';
import 'package:belluga_boilerplate/presentation/screens/tenants/dashboard/widgets/my_courses_dashboard/my_courses_dashboard.dart';
import 'package:belluga_boilerplate/presentation/widgets/course_tracks_sliver.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _controller = GetIt.I.get<MyCoursesDashboardController>();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainLogo(),
        automaticallyImplyLeading: false,
        actions: [ProfileActionButton()],
      ),
      bottomNavigationBar: TenantBottomNavigation(
        currentIndex: 0,
        onTap: _handleNavigationTap,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: NextEventsDashboard()),
          SliverToBoxAdapter(child: MyCoursesDashboard()),
          SliverToBoxAdapter(child: ExternalCoursesDashboard()),
          StreamValueBuilder<List<CourseBaseModel>>(
            onNullWidget: SliverToBoxAdapter(child: SizedBox.shrink()),
            streamValue: _controller.fastTracksItemsStreamValue,
            builder: (context, fastTracks) {
              if (fastTracks.isEmpty) {
                return SliverToBoxAdapter(child: SizedBox.shrink());
              }

              return SliverDashboardWidgetAnimated(
                isVisible: fastTracks.isNotEmpty,
                sliver: CourseTracksSliver(
                  showAllLabel: "Ver Todas",
                  onShowAllPressed: () =>
                      context.router.push(FastTrackListRoute()),
                  fastTracks: fastTracks,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleNavigationTap(int index) {
    if (index == 2) {
      context.router.push(const TenantMenuRoute());
      return;
    }

    if (index == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comunidades em breve')),
      );
    }
  }
}
