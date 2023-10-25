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
            if (selectedDateRange != null) ...[
              Text(
                'Selected Date Range: ${DateFormat.yMMMd().format(selectedDateRange!.start)} - ${DateFormat.yMMMd().format(selectedDateRange!.end)}',
              ),
              const SizedBox(height: 50),
            ],
            const Text('In-line date range picker'),
            const SizedBox(height: 25),
            Flexible(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SimpleDateRangePicker(
                    onChanged: (dates) =>
                        setState(() => selectedDateRange = dates),
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
          ],
        ),
      ),
    );
  }
}
