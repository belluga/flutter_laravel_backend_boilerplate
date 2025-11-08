class EventActionsDTO {
  final String id;
  final String label;
  final String? color;
  final String? externalUrl;
  final String openIn;
  final String? itemType;
  final String? itemId;

  EventActionsDTO({
    required this.id,
    required this.label,
    this.color,
    this.externalUrl,
    required this.openIn,
    this.itemType,
    this.itemId,
  });

  factory EventActionsDTO.fromJson(Map<String, dynamic> json) {
    return EventActionsDTO(
      id: json['id'],
      label: json['label'],
      color: json['color_hex'],
      externalUrl: json['open_data']['external_url'],
      openIn: json['open_in'],
      itemType: json['open_data']['item_type'],
      itemId: json['open_data']['item_id'],
    );
  }
}
