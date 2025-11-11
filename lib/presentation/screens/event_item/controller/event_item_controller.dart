import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/main.dart';
import 'package:festou_app/domain/events/event_model.dart';
import 'package:festou_app/infrastructure/repositories/events_repository.dart';

class EventItemController implements Disposable{

  final String eventSlug;
  late ColorScheme colorScheme;

  EventItemController({required this.eventSlug}){
    _init(eventSlug);

    scrollController.addListener(checkBuyButtonVisibility);
  }

  double _visibilityThreshold = 0.0;

  final mainButtonKey = GlobalKey();

  final scrollController = ScrollController();

  final _eventsRepository = GetIt.I.get<EventsRepository>();

  final eventStreamValue = StreamValue<EventModel?>();

  final mainBuyButtomIsVisible = StreamValue<bool>(defaultValue: true);

  EventModel get eventModel => eventStreamValue.value!;

  Future<void> _init(String slug) async {
    final EventModel _eventModel = await _eventsRepository.getEventBySlug(slug);
    colorScheme = await _eventModel.getColorScheme();
    eventStreamValue.addValue(_eventModel);
  }

  void setVisibilityThreshold(double threshold) {
    _visibilityThreshold = threshold;
  }

  void checkBuyButtonVisibility() {
    if(_visibilityThreshold > scrollController.offset ){
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