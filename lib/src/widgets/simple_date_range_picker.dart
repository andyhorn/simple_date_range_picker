import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/src/constants/constants.dart';
import 'package:simple_date_range_picker/src/extensions/date_time_extensions.dart';
import 'package:simple_date_range_picker/src/widgets/month_grid.dart';
import 'package:simple_date_range_picker/src/widgets/month_title.dart';

class SimpleDateRangePicker extends StatefulWidget {
  const SimpleDateRangePicker({
    super.key,
    required this.onChanged,
    this.initialDateRange,
    this.width = Constants.width,
  });

  final DateTimeRange? initialDateRange;
  final ValueChanged<DateTimeRange?> onChanged;
  final double width;

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
      _selectedDates = _getDateRange(
        start: widget.initialDateRange!.start,
        end: widget.initialDateRange!.end,
      );

      currentMonth = DateTime(
        widget.initialDateRange!.start.year,
        widget.initialDateRange!.start.month,
        1,
      );

      startDate = widget.initialDateRange!.start;
      endDate = widget.initialDateRange!.end;
    } else {
      _selectedDates = const [];
      currentMonth = DateTime.now();
    }
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
                icon: const Icon(Icons.chevron_left),
                onPressed: () => _moveToPreviousMonth(),
              ),
              MonthTitle(month: currentMonth),
              IconButton(
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
            ...selectedDates,
            if (startDate != null) startDate!,
            if (endDate != null) endDate!,
          }.toList(),
          onSelected: _onSelected,
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
    if (date == startDate) {
      startDate = null;
    } else if (date == endDate) {
      endDate = null;
    } else if (startDate != null && endDate != null) {
      endDate = null;
      startDate = date;
    } else if (endDate != null && date.isAfter(endDate!)) {
      startDate = endDate;
      endDate = date;
    } else if (startDate != null && date.isBefore(startDate!)) {
      startDate = date;
    } else if (startDate != null && endDate == null) {
      endDate = date;
    } else {
      startDate = date;
    }

    if (startDate != null && endDate != null) {
      selectedDates = _getDateRange(start: startDate!, end: endDate!);
    } else if (selectedDates.isNotEmpty) {
      selectedDates = const [];
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
