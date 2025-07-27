import 'package:unifast_portal/infrastructure/services/dal/dto/course/course_item_summary_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/course/teacher_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/events/event_type_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/thumb_dto.dart';

class EventDTO {
  String? id;
  String title;
  String content;
  EventTypeDTO type;
  ThumbDTO? thumb;
  String dateTimeStart;
  String dateTimeEnd;
  CourseItemSummaryDTO? courseItemSummary;
  List<TeacherDTO> teachers;
  List<ActionsDTO> actions;

  EventDTO({required this.id, required this.courseItemId, required this.content, this.position, this.colorHex});

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
      id: json['id'] as String,
      content: json['content'] as String,
      colorHex: json['color_hex'] as String?,
      position: json['position'] as String?,
      courseItemId: json['course_item_id'] as String,
    );
  }
}
