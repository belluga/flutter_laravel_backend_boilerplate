abstract class EventActionsDTO {
  String id;
  String type;
  String label;
  String? color;
  

  EventActionsDTO({
    required this.id,
    required this.type,
    required this.label,
    this.color,
  });

  factory EventActionsDTO.fromJson(Map<String, dynamic> json) {

    return switch(json['type']){
      "external_url" => EventActionExterna.fromJson(json),
      "couse_item" => EventActionCourseItemNavigation.fromJson(json),
      _ => throw Exception("Button type not existent."),
    };
  }
}