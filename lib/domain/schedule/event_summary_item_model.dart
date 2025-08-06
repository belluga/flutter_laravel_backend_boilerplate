import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_summary_item_dto.dart';

class EventSummaryItemModel {
  final String? color;
  final DateTime dateTimeStart;

  EventSummaryItemModel({
    this.color,
    required this.dateTimeStart,
  });

  factory EventSummaryItemModel.fromDTO(EventSummaryItemDTO dto) {
    return EventSummaryItemModel(
      color: dto.color,
      dateTimeStart: DateTime.parse(dto.dateTimeStart),
    );
  }
}
