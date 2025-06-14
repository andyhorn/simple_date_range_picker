import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
import 'package:simple_date_range_picker/src/constants/constants.dart';
import 'package:simple_date_range_picker/src/date_selection_type.dart';
import 'package:simple_date_range_picker/src/extensions/date_time_extensions.dart';
import 'package:simple_date_range_picker/src/widgets/date_item.dart';

class MonthGrid extends StatelessWidget {
  const MonthGrid({
    super.key,
    required this.month,
    required this.selectedDates,
    required this.onSelected,
    required this.config,
    this.maxWidth = Constants.width,
    this.style,
  });

  final DateTime month;
  final List<DateTime> selectedDates;
  final ValueChanged<DateTime> onSelected;
  final double maxWidth;
  final SimpleDateRangePickerStyle? style;
  final SimpleDateRangePickerConfig config;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month, 1).weekday;
    final firstDayIndex = firstDay == 7 ? 0 : firstDay;

    return SizedBox(
      width: min(
        maxWidth,
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
                style: style?.weekdayTextStyle?.copyWith(
                  color: style?.colors?.foregroundColor,
                ),
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

          return DateItem(
            date: calendarDate,
            selected: selectedDates.any(calendarDate.isSameDate),
            onSelected: () => onSelected(calendarDate),
            type: _getSelectionType(calendarDate),
            style: style,
            canSelect: config.enabledDatePredicate?.call(calendarDate) ?? true,
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

  DateSelectionType _getSelectionType(DateTime date) {
    if (!selectedDates.any(date.isSameDate)) {
      return DateSelectionType.none;
    }

    switch (config) {
      case SimpleDateRangePickerRange():
        final isFirst = selectedDates.first.isSameDate(date);
        final isLast = selectedDates.last.isSameDate(date);

        if (isFirst) {
          if (selectedDates.length == 1) {
            return DateSelectionType.single;
          }

          if (selectedDates.isNotEmpty) {
            return DateSelectionType.start;
          }
        }

        if (isLast) {
          if (selectedDates.isNotEmpty) {
            return DateSelectionType.end;
          }
        }

        return DateSelectionType.middle;
      case SimpleDateRangePickerSingle():
      case SimpleDateRangePickerMulti():
        return DateSelectionType.single;
    }
  }
}
