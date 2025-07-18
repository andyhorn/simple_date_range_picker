import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
import 'package:simple_date_range_picker/src/constants/constants.dart';
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
  late var config = widget.config;
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();

    _setCurrentMonthFromConfig(config);
  }

  @override
  void didUpdateWidget(SimpleDateRangePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    var didUpdate = false;

    if (oldWidget.config != widget.config) {
      config = widget.config;
      _setCurrentMonthFromConfig(widget.config);
      didUpdate = true;
    }

    if (oldWidget.style != widget.style) {
      didUpdate = true;
    }

    if (didUpdate) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.width,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                style: widget.style?.previousIconButtonStyle,
                icon: const Icon(Icons.chevron_left),
                onPressed: () => _moveToPreviousMonth(),
              ),
              Expanded(
                child: Center(
                  child: MonthTitle(
                    month: currentMonth,
                    textStyle: widget.style?.monthTitleTextStyle,
                  ),
                ),
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
          selectedDates: config.dates.toSet().toList(),
          onSelected: _onSelected,
          style: widget.style,
          config: widget.config,
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
    config.onSelected(date);
    setState(() {});
  }

  void _setCurrentMonthFromConfig(SimpleDateRangePickerConfig config) {
    switch (config) {
      case SimpleDateRangePickerRange(:final initialDateRange):
        if (initialDateRange != null) {
          currentMonth = DateTime(
            initialDateRange.start.year,
            initialDateRange.start.month,
            1,
          );
        } else {
          currentMonth = DateTime.now();
        }
        break;
      case SimpleDateRangePickerSingle(:final initialDate):
        if (initialDate != null) {
          currentMonth = DateTime(
            initialDate.year,
            initialDate.month,
            1,
          );
        } else {
          currentMonth = DateTime.now();
        }
        break;
      case SimpleDateRangePickerMulti(:final initialDates):
        if (initialDates?.isNotEmpty ?? false) {
          currentMonth = DateTime(
            initialDates!.first.year,
            initialDates.first.month,
            1,
          );
        } else {
          currentMonth = DateTime.now();
        }

        break;
    }
  }
}
