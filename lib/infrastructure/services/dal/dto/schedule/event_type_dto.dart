class EventTypeDTO {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String? icon;
  final String? color;

  EventTypeDTO({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.icon,
    this.color,
  });

  factory EventTypeDTO.fromJson(Map<String, dynamic> json) {
    return EventTypeDTO(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      icon: json['icon'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color,
    };
  }

}