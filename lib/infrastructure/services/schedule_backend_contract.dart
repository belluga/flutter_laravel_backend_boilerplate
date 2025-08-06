import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_summary_dto.dart';

abstract class ScheduleBackendContract {

  Future<EventSummaryDTO> getScheduleSummary();

  Future<EventDTO> getEvent(String eventId);

  Future<List<EventDTO>> getEventsByDate(DateTime date);

  Future<List<EventDTO>> filterEvents({String? typeId, String? itemId});
}
