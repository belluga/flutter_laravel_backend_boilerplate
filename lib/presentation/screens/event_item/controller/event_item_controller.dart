import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';
import 'package:belluga_boilerplate/domain/events/color_scheme_generator.dart';
import 'package:belluga_boilerplate/domain/repositories/schedule_repository_contract.dart';
import 'package:belluga_boilerplate/domain/schedule/event_model.dart';

class EventItemController implements Disposable {
  final _scheduleRepository = GetIt.I.get<ScheduleRepositoryContract>();

  final eventStreamValue = StreamValue<EventModel?>();
  final mainBuyButtomIsVisible = StreamValue<bool>(defaultValue: true);

  final scrollController = ScrollController();
  final mainButtonKey = GlobalKey();

  double _visibilityThreshold = 0.0;

  ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

  EventItemController() {
    scrollController.addListener(checkBuyButtonVisibility);
  }

  EventModel get eventModel => eventStreamValue.value!;

  Future<void> init(String eventId) async {
    final EventModel event = await _scheduleRepository.getEvent(eventId);
    colorScheme = await ColorSchemeGenerator.fromImageUri(
      event.thumb?.thumbUri.value,
    );
    eventStreamValue.addValue(event);
  }

  void setVisibilityThreshold(double threshold) {
    _visibilityThreshold = threshold;
  }

  void checkBuyButtonVisibility() {
    if (_visibilityThreshold > scrollController.offset) {
      _buyButtomIsVisible();
    } else {
      _buyButtomIsInvisible();
    }
  }

  void _buyButtomIsVisible() => mainBuyButtomIsVisible.addValue(true);

  void _buyButtomIsInvisible() => mainBuyButtomIsVisible.addValue(false);

  @override
  FutureOr onDispose() {
    scrollController.dispose();
    eventStreamValue.dispose();
    mainBuyButtomIsVisible.dispose();
  }
}
