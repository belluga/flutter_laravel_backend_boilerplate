import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final int eventCount;
  final double width;
  final EdgeInsets? padding;
  final void Function(DateTime) onTap;

  const DateItem({
    super.key,
    required this.date,
    required this.onTap,
    this.isSelected = false,
    this.eventCount = 0,
    this.padding,
    this.width = 70,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectDate,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('E').format(date).substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isToday()
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  radius: 15,
                  child: Text(date.day.toString(),
                      style: TextTheme.of(context).titleMedium),
                ),
              ),
              const SizedBox(height: 4),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    // height: 30,
                    width: 40,
                    child: eventCount == 0
                        ? SizedBox.shrink()
                        : Wrap(
                            spacing: 3,
                            runSpacing: 3,
                            alignment: WrapAlignment.center,
                            children: List.generate(
                              eventCount,
                              (index) => CircleAvatar(
                                radius: 3,
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isToday() {
    return DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year;
  }

  void _selectDate() {
    onTap(date);
  }
}
