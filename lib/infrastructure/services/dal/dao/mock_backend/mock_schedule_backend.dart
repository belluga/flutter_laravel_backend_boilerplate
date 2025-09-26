import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:belluga_boilerplate/application/extensions/is_same_day.dart';
import 'package:belluga_boilerplate/application/functions/today.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/schedule/event_dto.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/schedule/event_summary_dto.dart';
import 'package:belluga_boilerplate/infrastructure/services/dal/dto/schedule/event_summary_item_dto.dart';
import 'package:belluga_boilerplate/infrastructure/services/schedule_backend_contract.dart';

class MockScheduleBackend extends ScheduleBackendContract {
  @override
  Future<EventSummaryDTO> getScheduleSummary() async {
    await Future.delayed(Duration(seconds: 2));

    final scheduleSummaryJson =
        await rootBundle.loadString('assets/mock/events_summary.json');

    final List<dynamic> _eventsSummaryItemsJsonList =
        json.decode(scheduleSummaryJson);

    final _eventsSummaryItems =
        _eventsSummaryItemsJsonList.cast<Map<String, dynamic>>();

    final List<EventSummaryItemDTO> _eventSummaryItems = _eventsSummaryItems
        .map((item) => EventSummaryItemDTO.fromJson(item))
        .toList();

    return EventSummaryDTO(items: _eventSummaryItems);
  }

  @override
  Future<EventDTO> getEvent(String eventId) async {
    await Future.delayed(Duration(seconds: 2));

    final scheduleSummaryJson =
        await rootBundle.loadString('assets/mock/events.json');

    final List<dynamic> _eventsSummaryItemsJsonList =
        json.decode(scheduleSummaryJson);

    final _events = _eventsSummaryItemsJsonList.cast<Map<String, dynamic>>();

    final _selectedEvent = _events.firstWhere((item) => item['id'] == eventId);

    return EventDTO.fromJson(_selectedEvent);
  }

  @override
  Future<List<EventDTO>> getEventsByDate(DateTime date) async {
    await Future.delayed(Duration(seconds: 2));

    final scheduleSummaryJson =
        await rootBundle.loadString('assets/mock/events.json');

    final List<dynamic> _eventsSummaryItemsJsonList =
        json.decode(scheduleSummaryJson);

    final _events = _eventsSummaryItemsJsonList.cast<Map<String, dynamic>>();

    final _eventsOnDate = _events
        .where(
          (item) => DateTime.parse(item['date_time_start']).isSameDay(date),
        )
        .toList();

    return _eventsOnDate.map((event) => EventDTO.fromJson(event)).toList();
  }

  @override
  Future<List<EventDTO>> filterEvents({String? typeId, String? itemId}) async {
    await Future.delayed(Duration(seconds: 2));

    final scheduleSummaryJson =
        await rootBundle.loadString('assets/mock/events.json');

    final List<dynamic> _eventsSummaryItemsJsonList =
        json.decode(scheduleSummaryJson);

    final _events = _eventsSummaryItemsJsonList.cast<Map<String, dynamic>>();

    final _eventsFiltered = _events.where((item) {
      if (typeId != null && item['type']['id'] != typeId) {
        return false;
      }
      if (itemId != null && item['item_id'] != itemId) {
        return false;
      }
      return true;
    }).toList();

    return _eventsFiltered.map((event) => EventDTO.fromJson(event)).toList();
  }

  @override
  Future<List<EventDTO>> getLastEvents() async {
    await Future.delayed(Duration(seconds: 2));

    final scheduleSummaryJson =
        await rootBundle.loadString('assets/mock/events.json');

    final List<dynamic> _eventsSummaryItemsJsonList =
        json.decode(scheduleSummaryJson);

    final _events = _eventsSummaryItemsJsonList.cast<Map<String, dynamic>>();

    final DateTime _startDate = Today.today;
    final DateTime _endDate = DateTime(Today.today.year, (Today.today.month +2), 1).subtract(Duration(days: 1));

    final _eventsOnDate = _events.where((item) {
      final _testDate = DateTime.parse(item['date_time_start']);
      return _testDate.compareTo(_startDate) > 0 && _testDate.compareTo(_endDate) < 0;
    }).toList();

    return _eventsOnDate.map((event) => EventDTO.fromJson(event)).toList();
  }
}
