import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';

Future<DateTimeRange?> showSimpleDateRangePickerDialog(
  BuildContext context,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      DateTimeRange? dateRange;

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
              const SizedBox(height: 25),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, null),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, dateRange),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
