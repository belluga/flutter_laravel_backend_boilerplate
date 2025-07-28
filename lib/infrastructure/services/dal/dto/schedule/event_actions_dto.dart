class EventActionsDTO {
  final String id;
  final String type;
  final String label;
  final String? color;
  final String? externalUrl;
  final String? openIn;
  final String? itemType;
  final String? itemId;

  EventActionsDTO({
    required this.id,
    required this.type,
    required this.label,
    this.color,
    this.externalUrl,
    this.openIn,
    this.itemType,
    this.itemId,
  });

  factory EventActionsDTO.fromJson(Map<String, dynamic> json) {
    return EventActionsDTO(
      id: json['id'],
      type: json['type'],
      label: json['label'],
      color: json['color'],
      externalUrl: json['externalUrl'],
      openIn: json['openIn'],
      itemType: json['itemType'],
      itemId: json['itemId'],
    );
  }
}
