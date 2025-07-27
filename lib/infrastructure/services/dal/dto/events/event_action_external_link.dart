import 'package:unifast_portal/infrastructure/services/dal/dto/events/event_actions_dto.dart';

class EventActionExternalLink extends EventActionsDTO {

  final String url;
  final String openIn;


  EventActionExternalLink({
    required super.id,
    required super.type,
    required super.label,
    required this.url,
    this.openIn = "external_url",
    super.color,
  });

  factory EventActionExternalLink.fromJson(Map<String, dynamic> json) {

    return EventActionExternalLink(
      id: json['id'],
      type: json['type'],
      label: json['label'],
      url: json['url'],
      openIn: json['openIn'],
      color: json['color'],
    );
  }
}
