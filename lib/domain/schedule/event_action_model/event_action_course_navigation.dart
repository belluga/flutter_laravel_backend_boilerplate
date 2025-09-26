import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:belluga_boilerplate/application/router/app_router.gr.dart';
import 'package:belluga_boilerplate/domain/schedule/event_action_item_types.dart';
import 'package:belluga_boilerplate/domain/schedule/event_action_model/event_action_in_app_navigation.dart';

class EventActionCourseNavigation extends EventActionInAppNavigation {
  EventActionCourseNavigation({
    required super.id,
    required super.label,
    required super.color,
    required super.itemId,
    required super.itemType,
  }) : assert(itemType.value == EventActionItemTypes.courseItem,
            'EventActionCourseNavigation must be used with CourseItem type');

  @override
  void open(BuildContext context) async {
    final String _itemId = itemId.value;
    if (_itemId != "") {
      await context.router.push(CoursesListRoute());
      return;
    }
    await context.router.push(CourseRoute(courseItemId: _itemId));
  }
}