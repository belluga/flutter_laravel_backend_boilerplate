import 'package:unifast_portal/infrastructure/services/dal/dto/course/teacher_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_actions_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_type_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/thumb_dto.dart';

class EventDTO {
  final String? id;
  final EventTypeDTO type;
  final String title;
  final String content;
  final ThumbDTO? thumb;
  final String dateTimeStart;
  final List<TeacherDTO> teachers;
  final List<EventActionsDTO> actions;

  EventDTO({
    this.id,
    required this.type,
    required this.title,
    required this.content,
    this.thumb,
    required this.dateTimeStart,
    required this.teachers,
    required this.actions,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) {
    return EventDTO(
      id: json['id'],
      type: EventTypeDTO.fromJson(json['type']),
      title: json['title'],
      content: json['content'],
      thumb: ThumbDTO.fromJson(json['thumb']),
      dateTimeStart: json['date_time_start'],
      teachers: (json['teachers'] as List)
          .map((teacher) => TeacherDTO.fromJson(teacher))
          .toList(),
      actions: (json['actions'] as List)
          .map((action) => EventActionsDTO.fromJson(action))
          .toList(),
    );
  }
}
