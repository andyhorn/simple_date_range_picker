import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
import 'package:simple_date_range_picker/src/constants/constants.dart';

Future<DateTimeRange?> showSimpleDateRangePickerDialog(
  BuildContext context, {
  DateTimeRange? initialDateRange,
  SimpleDateRangePickerStyle? style,
  SimpleDateRangePickerConfig? config,
  Color? backgroundColor,
  ShapeBorder? shape,
  ButtonStyle? cancelButtonStyle,
  ButtonStyle? confirmButtonStyle,
  String cancelLabel = 'Cancel',
  String confirmLabel = 'OK',
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      DateTimeRange? dateRange;

      return _SimpleDateRangePickerDialog(
        picker: SimpleDateRangePicker(
          config: SimpleDateRangePickerRange(
            onChanged: (dates) => dateRange = dates,
            initialDateRange: initialDateRange,
          ),
          style: style,
        ),
        shape: shape,
        cancelButtonStyle: cancelButtonStyle,
        confirmButtonStyle: confirmButtonStyle,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        backgroundColor: backgroundColor,
        onSave: () => Navigator.pop(context, dateRange),
      );
    },
  );
}

Future<List<DateTime>?> showSimpleMultiDatePickerDialog(
  BuildContext context, {
  List<DateTime>? initialDates,
  SimpleDateRangePickerStyle? style,
  Color? backgroundColor,
  ShapeBorder? shape,
  ButtonStyle? cancelButtonStyle,
  ButtonStyle? confirmButtonStyle,
  String cancelLabel = 'Cancel',
  String confirmLabel = 'OK',
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      List<DateTime>? dates;

      return _SimpleDateRangePickerDialog(
        picker: SimpleDateRangePicker(
          config: SimpleDateRangePickerMulti(
            onChanged: (value) => dates = value,
            initialDates: initialDates,
          ),
          style: style,
        ),
        shape: shape,
        cancelButtonStyle: cancelButtonStyle,
        confirmButtonStyle: confirmButtonStyle,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        backgroundColor: backgroundColor,
        onSave: () => Navigator.pop(context, dates),
      );
    },
  );
}

Future<DateTime?> showSimpleDatePickerDialog(
  BuildContext context, {
  DateTime? initialDate,
  SimpleDateRangePickerStyle? style,
  Color? backgroundColor,
  ShapeBorder? shape,
  ButtonStyle? cancelButtonStyle,
  ButtonStyle? confirmButtonStyle,
  String cancelLabel = 'Cancel',
  String confirmLabel = 'OK',
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      DateTime? date;

      return _SimpleDateRangePickerDialog(
        picker: SimpleDateRangePicker(
          config: SimpleDateRangePickerSingle(
            onChanged: (value) => date = value,
            initialDate: initialDate,
          ),
          style: style,
        ),
        shape: shape,
        cancelButtonStyle: cancelButtonStyle,
        confirmButtonStyle: confirmButtonStyle,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        backgroundColor: backgroundColor,
        onSave: () => Navigator.pop(context, date),
      );
    },
  );
}

class _SimpleDateRangePickerDialog extends StatelessWidget {
  const _SimpleDateRangePickerDialog({
    required this.picker,
    required this.onSave,
    this.shape,
    this.cancelButtonStyle,
    this.confirmButtonStyle,
    this.cancelLabel = 'Cancel',
    this.confirmLabel = 'OK',
    this.backgroundColor,
  });

  final SimpleDateRangePicker picker;
  final ShapeBorder? shape;
  final ButtonStyle? cancelButtonStyle;
  final ButtonStyle? confirmButtonStyle;
  final String cancelLabel;
  final String confirmLabel;
  final Color? backgroundColor;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: shape ?? Constants.defaultDialogShape,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: Constants.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              picker,
              const SizedBox(height: 25),
              OverflowBar(
                children: [
                  ElevatedButton(
                    style: cancelButtonStyle,
                    onPressed: () => Navigator.pop(context, null),
                    child: Text(cancelLabel),
                  ),
                  ElevatedButton(
                    style: confirmButtonStyle,
                    onPressed: onSave,
                    child: Text(confirmLabel),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
