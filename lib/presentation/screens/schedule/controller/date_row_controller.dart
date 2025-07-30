import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class DateRowController implements Disposable {
  final scrollController = ScrollController();

  final selectedDateStreamValue = StreamValue(defaultValue: DateTime.now());

  void selectDate(DateTime date) => selectedDateStreamValue.addValue(date);

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  FutureOr onDispose() {
    scrollController.dispose();
    selectedDateStreamValue.dispose();
  }
}
