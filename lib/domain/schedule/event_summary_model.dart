import 'package:unifast_portal/domain/schedule/event_summary_item_model.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_summary_dto.dart';

class EventSummaryModel {
  final List<EventSummaryItemModel> items;

  EventSummaryModel({
    required this.items,
  });

  factory EventSummaryModel.fromDTO(EventSummaryDTO dto) {
    return EventSummaryModel(
      items: dto.items.map((e) => EventSummaryItemModel.fromDTO(e)).toList(),
    );
  }
}
