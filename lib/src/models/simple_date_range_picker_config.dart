import 'package:flutter/material.dart';

sealed class SimpleDateRangePickerConfig {
  const SimpleDateRangePickerConfig();

  List<DateTime> get dates;
}

class SimpleDateRangePickerRange extends SimpleDateRangePickerConfig {
  const SimpleDateRangePickerRange({
    required this.initialDateRange,
    required this.onChanged,
  });

  final DateTimeRange? initialDateRange;
  final ValueChanged<DateTimeRange?> onChanged;

  @override
  List<DateTime> get dates {
    if (initialDateRange == null) {
      return const [];
    }

    var dates = <DateTime>[];
    var date = initialDateRange!.start;

    while (date.isBefore(initialDateRange!.end)) {
      dates.add(date);
      date = date.add(const Duration(days: 1));
    }

    dates.add(initialDateRange!.end);
    return dates;
  }

  SimpleDateRangePickerRange copyWith({
    DateTimeRange? dateRange,
  }) {
    return SimpleDateRangePickerRange(
      initialDateRange: dateRange,
      onChanged: onChanged,
    );
  }
}
