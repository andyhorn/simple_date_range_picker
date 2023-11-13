import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
import 'package:simple_date_range_picker/src/constants/constants.dart';
import 'package:simple_date_range_picker/src/extensions/date_time_extensions.dart';
import 'package:simple_date_range_picker/src/widgets/month_grid.dart';
import 'package:simple_date_range_picker/src/widgets/month_title.dart';

class SimpleDateRangePicker extends StatefulWidget {
  const SimpleDateRangePicker({
    super.key,
    required this.config,
    this.width = Constants.width,
    this.style,
  });

  final double width;
  final SimpleDateRangePickerStyle? style;
  final SimpleDateRangePickerConfig config;

  @override
  State<SimpleDateRangePicker> createState() => _SimpleDateRangePickerState();
}

class _SimpleDateRangePickerState extends State<SimpleDateRangePicker> {
  late SimpleDateRangePickerConfig _selection = widget.config;
  late DateTime currentMonth;
  DateTime? startDate;
  DateTime? endDate;

  List<DateTime> get selection {
    return _selection.dates;
  }

  set selection(List<DateTime> value) {
    switch (widget.config) {
      case SimpleDateRangePickerRange(:final onChanged):
        final dateRange = value.isEmpty
            ? null
            : DateTimeRange(
                start: value.first,
                end: value.last,
              );

        _selection = SimpleDateRangePickerRange(
          initialDateRange: dateRange,
          onChanged: onChanged,
        );

        onChanged(dateRange);
    }
  }

  @override
  void initState() {
    super.initState();

    return switch (widget.config) {
      SimpleDateRangePickerRange(initialDateRange: final dateRange) => () {
          if (dateRange != null) {
            // _selection = dateRange;

            currentMonth = DateTime(
              dateRange.start.year,
              dateRange.start.month,
              1,
            );

            startDate = dateRange.start;
            endDate = dateRange.end;
          } else {
            // selection = const [];
            currentMonth = DateTime.now();
          }
        }(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                style: widget.style?.previousIconButtonStyle,
                icon: const Icon(Icons.chevron_left),
                onPressed: () => _moveToPreviousMonth(),
              ),
              MonthTitle(
                month: currentMonth,
                textStyle: widget.style?.monthTitleTextStyle,
              ),
              IconButton(
                style: widget.style?.nextIconButtonStyle,
                icon: const Icon(Icons.chevron_right),
                onPressed: () => _moveToNextMonth(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        MonthGrid(
          maxWidth: widget.width,
          month: currentMonth,
          selectedDates: {
            ...selection,
            if (startDate != null) startDate!,
            if (endDate != null) endDate!,
          }.toList(),
          onSelected: _onSelected,
          style: widget.style,
        ),
      ],
    );
  }

  void _moveToPreviousMonth() {
    setState(
      () => currentMonth = DateTime(
        currentMonth.year,
        currentMonth.month - 1,
        1,
      ),
    );
  }

  void _moveToNextMonth() {
    setState(
      () => currentMonth = DateTime(
        currentMonth.year,
        currentMonth.month + 1,
        1,
      ),
    );
  }

  void _onSelected(DateTime date) {
    switch (widget.config) {
      case SimpleDateRangePickerRange():
        // selecting the start date again resets the selection
        if (date == startDate) {
          startDate = null;
          // selecting the end date again resets the selection
        } else if (date == endDate) {
          endDate = null;
          // selecting a new date when both ends of the range have been selected
          // resets the selection with the new date as the start date
        } else if (startDate != null && endDate != null) {
          endDate = null;
          startDate = date;
          // selecting a date that lies after the end date moves the start date
          // to the current end date and sets the end date to the newly selected
          // date
        } else if (endDate != null && date.isAfter(endDate!)) {
          startDate = endDate;
          endDate = date;
          // selecting a date that lies before the current start date sets it as
          // the new start date
        } else if (startDate != null && date.isBefore(startDate!)) {
          startDate = date;
          // if no end date has been selected, the new date becomes the end date
        } else if (startDate != null && endDate == null) {
          endDate = date;
          // if all other conditions are false, this newly selected date is the
          // beginning of a new date range
        } else {
          startDate = date;
        }

        // after the selection has been made, if there is a selected start and
        // end date, create the full range of dates
        if (startDate != null && endDate != null) {
          selection = _getDateRange(start: startDate!, end: endDate!);
          // if there is only a start date, empty the range of dates
        } else if (selection.isNotEmpty) {
          selection = const [];
        }
    }

    setState(() {});
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
