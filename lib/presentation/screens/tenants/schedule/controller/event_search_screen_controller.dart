import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';
import 'package:belluga_boilerplate/domain/repositories/schedule_repository_contract.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';

class EventSearchScreenController implements Disposable {
  final _scheduleRepository = GetIt.I.get<ScheduleRepositoryContract>();

  final searchController = TextEditingController();
  final focusNode = FocusNode();

  final allEventsStreamValue = StreamValue<List<EventModel>?>();
  final searchResultsStreamValue = StreamValue<List<EventModel>?>();

  Future<void> init() async {
    allEventsStreamValue.addValue(null);
    searchResultsStreamValue.addValue(null);

    final List<EventModel> _allEvents = await _scheduleRepository.getLastEvents();

    final now = DateTime.now();
    _allEvents.sort((a, b) => a.dateTimeStart.value!.compareTo(b.dateTimeStart.value!));

    final upcomingEvents = _allEvents.where((event) =>
      event.dateTimeStart.value!.isAfter(now) ||
      event.dateTimeStart.value!.isAtSameMomentAs(now)
    ).toList();

    allEventsStreamValue.addValue(upcomingEvents);
    searchResultsStreamValue.addValue(upcomingEvents);
  }

  void searchEvents(String query) {
    if (query.isEmpty) {
      searchResultsStreamValue.addValue([]);
      return;
    }

    final allEvents = allEventsStreamValue.value ?? [];
    final lowercaseQuery = query.toLowerCase();

    final filteredEvents = allEvents.where((event) {
      final titleMatch = event.title.value.toLowerCase().contains(lowercaseQuery);
      final contentMatch = (event.content.value ?? "").toLowerCase().contains(lowercaseQuery);
      final teacherMatch = event.teachers.any(
        (teacher) => teacher.name.value.toLowerCase().contains(lowercaseQuery),
      );

      return titleMatch || contentMatch || teacherMatch;
    }).toList();

    searchResultsStreamValue.addValue(filteredEvents);
  }

  @override
  void onDispose() {
    allEventsStreamValue.dispose();
    searchResultsStreamValue.dispose();
    searchController.dispose();
    focusNode.dispose();
  }
}