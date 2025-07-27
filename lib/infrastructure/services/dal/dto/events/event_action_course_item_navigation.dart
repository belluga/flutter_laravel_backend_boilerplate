import 'package:unifast_portal/infrastructure/services/dal/dto/course/course_item_summary_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/events/event_actions_dto.dart';

class EventActionCourseItemNavigation extends EventActionsDTO {

  final CourseItemSummaryDTO courseItem;


  EventActionCourseItemNavigation({
    required super.id,
    required super.type,
    required super.label,
    required this.courseItem,
    super.color,
  });

  factory EventActionCourseItemNavigation.fromJson(Map<String, dynamic> json) {

    final _courseItem = CourseItemSummaryDTO.fromJson(json['courseItem']);

    return EventActionCourseItemNavigation(
      id: json['id'],
      type: json['type'],
      label: json['label'],
      courseItem: _courseItem,
      color: json['color'],
    );
  }
}
