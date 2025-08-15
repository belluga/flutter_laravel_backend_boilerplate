import 'package:get_it/get_it.dart';
import 'package:stream_value/main.dart';
import 'package:unifast_portal/domain/repositories/schedule_repository_contract.dart';
import 'package:unifast_portal/domain/schedule/event_model.dart';

class NextEventsDashboardController {
  final _scheduleRepository = GetIt.I.get< ScheduleRepositoryContract>();

  final nextEventsStreamValue = StreamValue<List<EventModel>?>(defaultValue: null);

  Future<void> init() async {
    await _getNextEvents();
  }

  Future<void> _getNextEvents() async {
    final List<EventModel> _lastEvents = await _scheduleRepository.getLastEvents();
    nextEventsStreamValue.addValue(_lastEvents);
  }
  
}