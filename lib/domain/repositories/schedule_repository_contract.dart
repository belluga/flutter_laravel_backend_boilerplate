import 'package:get_it/get_it.dart';
import 'package:unifast_portal/domain/schedule/event_model.dart';
import 'package:unifast_portal/domain/schedule/schedule_summary_model.dart';
import 'package:unifast_portal/infrastructure/services/backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/schedule/event_summary_dto.dart';

class ScheduleRepositoryContract {
  BackendContract get backend => GetIt.I.get<BackendContract>();

  Future<ScheduleSummaryModel> getScheduleSummary() async {
    final EventSummaryDTO _eventSummaryDTO =
        await backend.schedule.getScheduleSummary();

    return ScheduleSummaryModel.fromDTO(_eventSummaryDTO);
  }
  
  Future<EventModel> getEvent(String eventId) async {
    final EventDTO _eventDTO = await backend.schedule.getEvent(eventId);
    return EventModel.fromDTO(_eventDTO);
  }

  Future<List<EventModel>> getEventsByDate(DateTime date) async {
    final List<EventDTO> _events = await backend.schedule.getEventsByDate(date);
    return _events.map((e) => EventModel.fromDTO(e)).toList();
  }

  Future<List<EventModel>> filterEvents({String? typeId, String? itemId}) async {
     final List<EventDTO> _events = await backend.schedule.filterEvents(typeId: typeId, itemId: itemId);
     return _events.map((event) => EventModel.fromDTO(event)).toList();
  }

  Future<List<EventModel>> getLastEvents() async {
    final List<EventDTO> _events = await backend.schedule.getLastEvents();
     return _events.map((event) => EventModel.fromDTO(event)).toList();
  }

}