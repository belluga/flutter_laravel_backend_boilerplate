import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:unifast_portal/presentation/screens/schedule/controller/date_row_controller.dart';
import 'date_item.dart'; // Make sure to import your DateItem widget

class DateRow extends StatefulWidget {
  const DateRow({super.key});

  @override
  State<DateRow> createState() => _DateRowState();
}

class _DateRowState extends State<DateRow> {
  late DateRowController _controller;

  static const int _veryLargeNumber = 81;
  static const int _initialIndex = _veryLargeNumber ~/ 2;
  static const double _itemWidth = 70.0;
  static const double _itemPadding = 8.0;
  static const double _totalItemWidth = _itemWidth + _itemPadding;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.registerSingleton(DateRowController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Define a fixed height for the horizontal scroller
      child: ListView.builder(
          itemCount: _veryLargeNumber,
          scrollDirection: Axis.horizontal,
          controller: _controller.scrollController,
          itemBuilder: (context, index) {
            final int difference = index - _initialIndex;
            final DateTime date =
                DateTime.now().add(Duration(days: difference));

            final int eventCount = Random.secure().nextInt(10);

            return InkWell(
              onTap: () {
                _controller.selectDate(date);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _itemPadding / 2),
                child: StreamValueBuilder<DateTime>(
                    streamValue: _controller.selectedDateStreamValue,
                    builder: (context, selectedDate) {
                      return DateItem(
                        date: date,
                        isSelected: _controller.isSameDay(
                            date, _controller.selectedDateStreamValue.value),
                        eventCount: eventCount,
                      );
                    }),
              ),
            );
          }),
    );
  }

  void _jumpToToday() {
    final screenWidth = MediaQuery.of(context).size.width;
    final centerOffset = (screenWidth / 2) - (_totalItemWidth / 2);

    _controller.scrollController.jumpTo(
      (_initialIndex * _totalItemWidth) - centerOffset,
    );
  }

  @override
  void dispose() {
    super.dispose();
    GetIt.I.unregister<DateRowController>();
  }
}
