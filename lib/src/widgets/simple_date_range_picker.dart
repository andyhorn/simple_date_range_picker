import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_date_range_picker/src/extensions/date_time_extensions.dart';
import 'package:simple_date_range_picker/src/selection_type.dart';
import 'package:simple_date_range_picker/src/widgets/month_title.dart';

class SimpleDateRangePicker extends StatefulWidget {
  const SimpleDateRangePicker({
    super.key,
    required this.onChanged,
    this.initialDateRange,
  });

  final DateTimeRange? initialDateRange;
  final ValueChanged<DateTimeRange?> onChanged;
  static const _dimension = 300.0;

  @override
  State<SimpleDateRangePicker> createState() => _SimpleDateRangePickerState();
}

class _SimpleDateRangePickerState extends State<SimpleDateRangePicker> {
  late List<DateTime> _selectedDates;
  late DateTime currentMonth;
  DateTime? startDate;
  DateTime? endDate;

  List<DateTime> get selectedDates {
    return _selectedDates;
  }

  set selectedDates(List<DateTime> value) {
    _selectedDates = value;

    if (_selectedDates.isEmpty) {
      widget.onChanged(null);
    } else {
      widget.onChanged(DateTimeRange(
        start: _selectedDates.first,
        end: _selectedDates.last,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialDateRange != null) {
      selectedDates = _getDateRange(
        start: widget.initialDateRange!.start,
        end: widget.initialDateRange!.end,
      );

      currentMonth = DateTime(
        widget.initialDateRange!.start.year,
        widget.initialDateRange!.start.month,
        1,
      );
    } else {
      selectedDates = const [];
      currentMonth = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: SimpleDateRangePicker._dimension,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(
                  () => currentMonth = DateTime(
                    currentMonth.year,
                    currentMonth.month - 1,
                    1,
                  ),
                ),
              ),
              MonthTitle(month: currentMonth),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(
                  () => currentMonth = DateTime(
                    currentMonth.year,
                    currentMonth.month + 1,
                    1,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _MonthDisplay(
          month: currentMonth,
          selectedDates: selectedDates,
          onSelected: (date) {
            if (date == startDate) {
              startDate = null;
            } else if (date == endDate) {
              endDate = null;
            } else if (startDate != null && endDate != null) {
              endDate = null;
              startDate = date;
            } else if (startDate != null && date.isBefore(startDate!)) {
              startDate = date;
            } else if (startDate != null && endDate == null) {
              endDate = date;
            } else {
              startDate = date;
            }

            if (startDate != null && endDate != null) {
              selectedDates = _getDateRange(
                start: startDate!,
                end: endDate!,
              );
            } else if (startDate != null) {
              selectedDates = [startDate!];
            } else if (endDate != null) {
              selectedDates = [endDate!];
            } else {
              selectedDates = const [];
            }

            setState(() {});
          },
        ),
        const SizedBox(height: 15),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedDates.isNotEmpty) ...[
              Text(
                DateFormat.yMMMMd().format(selectedDates.first),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              if (selectedDates.length > 1) ...[
                const SizedBox(width: 5),
                const Text('-'),
                const SizedBox(width: 5),
                Text(
                  DateFormat.yMMMMd().format(selectedDates.last),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ],
          ],
        ),
      ],
    );
  }

  List<DateTime> _getDateRange({
    required DateTime start,
    required DateTime end,
  }) {
    final dates = <DateTime>[];
    var date = start;

    while (date.isBefore(end) || date.isSameDate(end)) {
      dates.add(date);
      date = date.add(const Duration(days: 1));
    }

    return dates;
  }
}

class _MonthDisplay extends StatelessWidget {
  const _MonthDisplay({
    required this.month,
    required this.selectedDates,
    required this.onSelected,
  });

  final DateTime month;
  final List<DateTime> selectedDates;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month, 1).weekday;
    final firstDayIndex = firstDay == 7 ? 0 : firstDay;

    return SizedBox(
      width: min(
        SimpleDateRangePicker._dimension,
        MediaQuery.sizeOf(context).width * 0.75,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (context, index) {
          if (index < 7) {
            return Center(
              child: Text(
                DateFormat.E().format(_getWeekday(index == 0 ? 7 : index)),
                textAlign: TextAlign.center,
              ),
            );
          }

          final calendarIndex = index - 7;

          if (calendarIndex < firstDayIndex) {
            return const SizedBox.shrink();
          }

          final calendarDate = DateTime(
            month.year,
            month.month,
            calendarIndex - firstDayIndex + 1,
          );

          return _DateItem(
            date: calendarDate,
            selected: selectedDates.contains(calendarDate),
            onSelected: () => onSelected(calendarDate),
            type: _getSelectionType(calendarDate),
          );
        },
        itemCount: _getItemCount(),
      ),
    );
  }

  int _getItemCount() {
    const headerCount = 7;
    final lastDay = DateTime(month.year, month.month + 1, 0).day;
    final firstWeekday = DateTime(month.year, month.month, 1).weekday;
    final numEmptySpaces = firstWeekday == 7 ? 0 : firstWeekday;

    return headerCount + lastDay + numEmptySpaces;
  }

  DateTime _getWeekday(int weekday) {
    var date = DateTime.now();

    while (date.weekday != weekday) {
      date = date.add(const Duration(days: 1));
    }

    return date;
  }

  SelectionType _getSelectionType(DateTime date) {
    if (!selectedDates.contains(date)) {
      return SelectionType.none;
    }

    if (selectedDates.length == 1 && selectedDates.first == date) {
      return SelectionType.single;
    }

    if (selectedDates.isNotEmpty && selectedDates.first == date) {
      return SelectionType.start;
    }

    if (selectedDates.isNotEmpty && selectedDates.last == date) {
      return SelectionType.end;
    }

    return SelectionType.middle;
  }
}

class _DateItem extends StatefulWidget {
  const _DateItem({
    required this.date,
    required this.selected,
    required this.type,
    required this.onSelected,
  });

  final DateTime date;
  final bool selected;
  final SelectionType type;
  final VoidCallback onSelected;

  @override
  State<_DateItem> createState() => __DateItemState();
}

class __DateItemState extends State<_DateItem> {
  var hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hovered = true),
        onExit: (_) => setState(() => hovered = false),
        child: GestureDetector(
          onTap: () => widget.onSelected(),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: switch (widget.type) {
                  SelectionType.none => Radius.zero,
                  SelectionType.end => Radius.zero,
                  SelectionType.middle => Radius.zero,
                  SelectionType.single => const Radius.circular(4),
                  SelectionType.start => const Radius.circular(4),
                },
                right: switch (widget.type) {
                  SelectionType.none => Radius.zero,
                  SelectionType.end => const Radius.circular(4),
                  SelectionType.middle => Radius.zero,
                  SelectionType.single => const Radius.circular(4),
                  SelectionType.start => Radius.zero,
                },
              ),
              color: _getColor(),
            ),
            child: Center(
              child: Text('${widget.date.day}', textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }

  Color? _getColor() {
    const boundaryOpacity = 0.3;
    const hoveredOpacity = 0.4;
    const selectedOpacity = 0.2;

    return switch (widget.type) {
      SelectionType.none => hovered
          ? Theme.of(context).colorScheme.primary.withOpacity(hoveredOpacity)
          : null,
      SelectionType.end => Theme.of(context).colorScheme.primary.withOpacity(
            hovered ? hoveredOpacity : boundaryOpacity,
          ),
      SelectionType.middle => Theme.of(context).colorScheme.primary.withOpacity(
            hovered ? hoveredOpacity : selectedOpacity,
          ),
      SelectionType.single => Theme.of(context).colorScheme.primary.withOpacity(
            hovered ? hoveredOpacity : boundaryOpacity,
          ),
      SelectionType.start => Theme.of(context).colorScheme.primary.withOpacity(
            hovered ? hoveredOpacity : boundaryOpacity,
          ),
    };
  }
}
