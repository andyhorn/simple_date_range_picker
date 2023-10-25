import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';

Future<DateTimeRange?> showSimpleDateRangePickerDialog(
  BuildContext context, {
  List<Widget>? actions,
}) async {
  DateTimeRange? dateRange;

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog.fullscreen(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SimpleDateRangePicker(
                onChanged: (dates) => dateRange = dates,
              ),
              if (actions != null) ...[
                const SizedBox(height: 25),
                ...actions,
              ],
            ],
          ),
        ),
      );
    },
  );

  return dateRange;
}
