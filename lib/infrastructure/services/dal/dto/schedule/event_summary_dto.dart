import 'package:belluga_boilerplate/infrastructure/services/dal/dto/schedule/event_summary_item_dto.dart';

class EventSummaryDTO {
  final List<EventSummaryItemDTO> items;

  EventSummaryDTO({
    required this.items,
  });

  factory EventSummaryDTO.fromJson(Map<String, dynamic> json) {
    return EventSummaryDTO(
      items: (json['items'] as List<dynamic>)
          .map((e) => EventSummaryItemDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
