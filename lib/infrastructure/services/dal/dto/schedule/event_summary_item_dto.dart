class EventSummaryItemDTO {
  final String? color;
  final String dateTimeStart;

  EventSummaryItemDTO({
    this.color,
    required this.dateTimeStart,
  });

  factory EventSummaryItemDTO.fromJson(Map<String, dynamic> json) {
    return EventSummaryItemDTO(
      color: json['color'],
      dateTimeStart: json['dateTimeStart'],
    );
  }
}