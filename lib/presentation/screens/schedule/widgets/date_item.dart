import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final int eventCount;

  const DateItem({
    super.key,
    required this.date,
    this.isSelected = false,
    this.eventCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: 70, // Slightly reduced width for better spacing
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
    );
  }

  bool _isToday() {
    return DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year;
  }
}
