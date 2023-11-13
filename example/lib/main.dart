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
                  backgroundColor: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  cancelButtonStyle: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.red.shade500,
                    ),
                    foregroundColor: const MaterialStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  confirmButtonStyle: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.black12,
                    ),
                    foregroundColor: const MaterialStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  style: SimpleDateRangePickerStyle(
                    colors: const SimpleDateRangePickerColors(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      boundaryOpacity: 0.8,
                      hoveredOpacity: 0.9,
                      selectedOpacity: 0.5,
                    ),
                    monthTitleTextStyle: Theme.of(context).textTheme.titleLarge,
                    weekdayTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    dayTextStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    activeItemRadius: Radius.zero,
                    previousIconButtonStyle: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(),
                      ),
                    ),
                    nextIconButtonStyle: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(),
                      ),
                    ),
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
