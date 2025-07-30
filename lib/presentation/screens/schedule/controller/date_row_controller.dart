import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class DateRowController implements Disposable {
  final int totalItems = 81;
  late int initialIndex = totalItems ~/ 2;

  static DateTime get today =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateRowController() {
    visibleDatesStreamValue.stream.listen(updateCurrentMonth);
    invisibleDatesStreamValue.stream.listen(updateCurrentMonth);
  }

  final scrollController = ScrollController();

  final selectedDateStreamValue =
      StreamValue<DateTime>(defaultValue: DateRowController.today);

  final firsVisibleDateStreamValue =
      StreamValue<DateTime>(defaultValue: DateRowController.today);

  final visibleDatesStreamValue = StreamValue<List<DateTime>>(defaultValue: []);

  final invisibleDatesStreamValue =
      StreamValue<List<DateTime>>(defaultValue: []);

  void selectDate(DateTime date) => selectedDateStreamValue.addValue(date);

  void becomeVisible(DateTime date) {
    final List<DateTime> _dates = visibleDatesStreamValue.value;
    _dates.add(date);
    _dates.sort((a, b) => a.compareTo(b));
    visibleDatesStreamValue.addValue(_dates);
  }

  void becomeInvisible(DateTime date) {
    final List<DateTime> _dates = invisibleDatesStreamValue.value;
    _dates.add(date);
    _dates.sort((a, b) => a.compareTo(b));
    invisibleDatesStreamValue.addValue(_dates);
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void updateCurrentMonth(List<DateTime> dates) {
    final List<DateTime> _visibleDates = visibleDatesStreamValue.value;
    final List<DateTime> _invisibleDates = invisibleDatesStreamValue.value;

    _visibleDates.removeWhere((element) => _invisibleDates.contains(element));
    _invisibleDates.clear();
    final _firstDate = _visibleDates.first;
    firsVisibleDateStreamValue.addValue(_firstDate);
  }

  DateTime getDateByIndex(int index) =>
      DateRowController.today.add(Duration(days: index - initialIndex));

  int getIndexByDate(DateTime date) =>
      initialIndex + (date.difference(DateRowController.today).inDays);

  @override
  FutureOr onDispose() {
    print("onDispose");
    scrollController.dispose();
    selectedDateStreamValue.dispose();
    firsVisibleDateStreamValue.dispose();
    visibleDatesStreamValue.dispose();
    invisibleDatesStreamValue.dispose();
  }
}
