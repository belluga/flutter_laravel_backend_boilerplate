import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:unifast_portal/presentation/screens/schedule/controller/date_row_controller.dart';
import 'date_item.dart';

class DateRow extends StatefulWidget {
  const DateRow({super.key});

  @override
  State<DateRow> createState() => _DateRowState();
}

class _DateRowState extends State<DateRow> {
  final _controller = GetIt.I<DateRowController>();

  static const int _veryLargeNumber = 81;
  static const int _initialIndex = _veryLargeNumber ~/ 2;
  static const double _itemWidth = 70.0;
  static const double _itemPadding = 8.0;
  static const double _totalItemWidth = _itemWidth + (_itemPadding * 2);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("_jumpToToday");
      _jumpToToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          itemCount: _veryLargeNumber,
          scrollDirection: Axis.horizontal,
          controller: _controller.scrollController,
          itemBuilder: (context, index) {
            final int difference = index - _initialIndex;
            final DateTime date =
                DateTime.now().add(Duration(days: difference));

            final int eventCount = Random.secure().nextInt(10);

            return VisibilityDetector(
              key: Key('date_item_$index'),
              onVisibilityChanged: (visibilityInfo) {
                final visibleFraction = visibilityInfo.visibleFraction;
                if (mounted) {
                  if (visibleFraction > 0.0) {
                    _controller.becomeVisible(date);
                  } else {
                    _controller.becomeInvisible(date);
                  }
                }
              },
              child: StreamValueBuilder<DateTime>(
                  streamValue: _controller.selectedDateStreamValue,
                  builder: (context, asyncSnapshot) {
                    return DateItem(
                      date: date,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      onTap: _controller.selectDate,
                      isSelected: _controller.isSameDay(
                          date, _controller.selectedDateStreamValue.value),
                      eventCount: eventCount,
                    );
                  }),
            );
          }),
    );
  }

  void _jumpToToday() {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _centerOffset = (_screenWidth / 2) - (_totalItemWidth / 2);
    final _scrollTo = (_initialIndex * _totalItemWidth) - _centerOffset;
    _controller.scrollController.jumpTo(_scrollTo);
  }
}
