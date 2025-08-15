import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:unifast_portal/domain/schedule/schedule_summary_item_model.dart';
import 'package:unifast_portal/presentation/screens/schedule/controller/schedule_screen_controller.dart';

class DateItem extends StatefulWidget {
  final DateTime date;
  final bool isSelected;
  final double width;
  final EdgeInsets? padding;
  final void Function(DateTime) onTap;

  const DateItem({
    super.key,
    required this.date,
    required this.onTap,
    this.isSelected = false,
    this.padding,
    this.width = 70,
  });

  @override
  State<DateItem> createState() => _DateItemState();
}

class _DateItemState extends State<DateItem> {
  final _controller = GetIt.I.get<ScheduleScreenController>();

  @override
  Widget build(BuildContext context) {
    final List<ScheduleSummaryItemModel> _eventItems =
        _controller.getEventsSummaryByDate(widget.date);

    return InkWell(
      onTap: _selectDate,
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: widget.width,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('E')
                    .format(widget.date)
                    .substring(0, 1)
                    .toUpperCase(),
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
                  backgroundColor: widget.isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  radius: 15,
                  child: Text(widget.date.day.toString(),
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
                    child: _eventItems.isEmpty
                        ? SizedBox.shrink()
                        : Wrap(
                            spacing: 3,
                            runSpacing: 3,
                            alignment: WrapAlignment.center,
                            children: List.generate(
                              _eventItems.length,
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
    return DateTime.now().day == widget.date.day &&
        DateTime.now().month == widget.date.month &&
        DateTime.now().year == widget.date.year;
  }

  void _selectDate() {
    widget.onTap(widget.date);
  }
}
