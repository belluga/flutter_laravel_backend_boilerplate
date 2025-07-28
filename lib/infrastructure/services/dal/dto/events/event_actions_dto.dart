import 'package:unifast_portal/infrastructure/services/dal/dto/course/course_item_summary_dto.dart';

class EventActionsDTO {
  final String id;
  final String type;
  final String label;
  final String? color;
  final String? externalUrl;
  final String? openIn;
  final CourseItemSummaryDTO? courseItem;

  EventActionsDTO({
    required this.id,
    required this.type,
    required this.label,
    this.color,
    this.externalUrl,
    this.openIn,
    this.courseItem,
  });

  factory EventActionsDTO.fromJson(Map<String, dynamic> json) {
    return EventActionsDTO(
      id: json['id'],
      type: json['type'],
      label: json['label'],
      color: json['color'],
      externalUrl: json['externalUrl'],
      openIn: json['openIn'],
      courseItem: CourseItemSummaryDTO.fromJson(json['courseItem']),
    );
  }
}
