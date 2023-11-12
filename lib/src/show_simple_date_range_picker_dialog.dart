import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
import 'package:simple_date_range_picker/src/constants/constants.dart';

Future<DateTimeRange?> showSimpleDateRangePickerDialog(
  BuildContext context, {
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
      DateTimeRange? dateRange;

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
                SimpleDateRangePicker(
                  onChanged: (dates) => dateRange = dates,
                  style: style,
                ),
                const SizedBox(height: 25),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      style: cancelButtonStyle,
                      onPressed: () => Navigator.pop(context, null),
                      child: Text(cancelLabel),
                    ),
                    ElevatedButton(
                      style: confirmButtonStyle,
                      onPressed: () => Navigator.pop(context, dateRange),
                      child: Text(confirmLabel),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
