import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleDateRangePicker Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (selectedDateRange == null) ...[
              const Text('No date range selected'),
            ] else ...[
              Text(
                'Selected Date Range: ${DateFormat.yMMMd().format(selectedDateRange!.start)} - ${DateFormat.yMMMd().format(selectedDateRange!.end)}',
              ),
            ],
            const SizedBox(height: 50),
            const Text('In-line date range picker'),
            const SizedBox(height: 25),
            Flexible(
              child: SimpleDateRangePicker(
                onChanged: (dates) => setState(() => selectedDateRange = dates),
                style: const SimpleDateRangePickerStyle(
                  colors: SimpleDateRangePickerColors(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                final dates = await showSimpleDateRangePickerDialog(context);

                if (dates != null) {
                  setState(() => selectedDateRange = dates);
                }
              },
              child: const Text('showSimpleDateRangePickerDialog'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                final dates = await showSimpleDateRangePickerDialog(
                  context,
                  backgroundColor: Colors.amber,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  cancelButtonStyle: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                  ),
                  confirmButtonStyle: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                  ),
                  style: SimpleDateRangePickerStyle(
                    colors: const SimpleDateRangePickerColors(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.black,
                    ),
                    monthTitleTextStyle: Theme.of(context).textTheme.bodyLarge,
                    weekdayTextStyle: const TextStyle(
                      fontFamily: 'Sans Serif',
                      fontWeight: FontWeight.bold,
                    ),
                    dayTextStyle: const TextStyle(
                      fontFamily: 'Serif',
                      decoration: TextDecoration.underline,
                      fontSize: 22,
                    ),
                    activeItemRadius: const Radius.circular(12.0),
                  ),
                  cancelLabel: 'Discard',
                  confirmLabel: 'Save',
                );

                if (dates != null) {
                  setState(() => selectedDateRange = dates);
                }
              },
              child: const Text(
                'showSimpleDateRangePickerDialog (Custom)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
