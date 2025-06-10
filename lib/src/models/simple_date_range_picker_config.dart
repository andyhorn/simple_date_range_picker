import 'package:flutter/material.dart';

sealed class SimpleDateRangePickerConfig {
  const SimpleDateRangePickerConfig({
    this.enabledDatePredicate,
  });

  List<DateTime> get dates;
  void onSelected(DateTime date);

  final bool Function(DateTime date)? enabledDatePredicate;
}

class SimpleDateRangePickerRange extends SimpleDateRangePickerConfig {
  SimpleDateRangePickerRange({
    required this.initialDateRange,
    required this.onChanged,
    super.enabledDatePredicate,
  })  : _startDate = initialDateRange?.start,
        _endDate = initialDateRange?.end;

  final DateTimeRange? initialDateRange;
  final ValueChanged<DateTimeRange?> onChanged;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void onSelected(DateTime date) {
    // selecting the start date again resets the selection
    if (date == _startDate) {
      _startDate = null;
      // selecting the end date again resets the selection
    } else if (date == _endDate) {
      _endDate = null;
      // selecting a new date when both ends of the range have been selected
      // resets the selection with the new date as the start date
    } else if (_startDate != null && _endDate != null) {
      _endDate = null;
      _startDate = date;
      // selecting a date that lies after the end date moves the start date
      // to the current end date and sets the end date to the newly selected
      // date
    } else if (_endDate != null && date.isAfter(_endDate!)) {
      _startDate = _endDate;
      _endDate = date;
      // selecting a date that lies before the current start date sets it as
      // the new start date
    } else if (_startDate != null && date.isBefore(_startDate!)) {
      _startDate = date;
      // if no end date has been selected, the new date becomes the end date
    } else if (_startDate != null && _endDate == null) {
      _endDate = date;
      // if all other conditions are false, this newly selected date is the
      // beginning of a new date range
    } else {
      _startDate = date;
    }

    if (_startDate == null || _endDate == null) {
      onChanged(null);
    } else {
      onChanged(DateTimeRange(start: _startDate!, end: _endDate!));
    }
  }

  @override
  List<DateTime> get dates {
    if (_startDate == null && _endDate == null) {
      return const [];
    }

    if (_endDate == null) {
      return [_startDate!];
    }

    if (_startDate == null) {
      return [_endDate!];
    }

    var dates = <DateTime>[];
    var date = _startDate!;

    while (date.isBefore(_endDate!)) {
      dates.add(date);
      date = date.add(const Duration(days: 1));
    }

    dates.add(_endDate!);
    return dates;
  }
}

class SimpleDateRangePickerSingle extends SimpleDateRangePickerConfig {
  SimpleDateRangePickerSingle({
    required this.initialDate,
    required this.onChanged,
    super.enabledDatePredicate,
  }) : _selectedDate = initialDate;

  final DateTime? initialDate;
  final ValueChanged<DateTime?> onChanged;
  DateTime? _selectedDate;

  @override
  List<DateTime> get dates {
    if (_selectedDate == null) {
      return const [];
    }

    return [_selectedDate!];
  }

  @override
  void onSelected(DateTime date) {
    if (date == _selectedDate) {
      _selectedDate = null;
    } else {
      _selectedDate = date;
    }

    onChanged(_selectedDate);
  }
}
