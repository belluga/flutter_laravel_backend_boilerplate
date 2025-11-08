import 'package:get_it/get_it.dart';
import 'package:stream_value/main.dart';
import 'package:belluga_boilerplate/domain/repositories/schedule_repository_contract.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';

class NextEventsDashboardController {
  final _scheduleRepository = GetIt.I.get< ScheduleRepositoryContract>();

  final nextEventsStreamValue = StreamValue<List<EventModel>?>(defaultValue: null);

  Future<void> init() async {
    await _getNextEvents();
  }

  Future<void> _getNextEvents() async {
    final List<EventModel> _lastEvents = await _scheduleRepository.getFutureEvents();
    nextEventsStreamValue.addValue(_lastEvents);
  }
  
}