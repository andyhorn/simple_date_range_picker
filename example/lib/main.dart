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
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: const Text('showSimpleDateRangePickerDialog'),
            onPressed: () async {
              final newDates = await showSimpleDateRangePickerDialog(context);

              if (newDates != null) {
                setState(() => selectedDateRange = newDates);
              }
            },
          ),
          ElevatedButton(
            child: const Text('showSimpleDatePickerDialog'),
            onPressed: () async {
              final newDate = await showSimpleDatePickerDialog(context);

              if (newDate != null) {
                setState(() => selectedDate = newDate);
              }
            },
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'In-line date range picker',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),
                            if (selectedDateRange == null) ...[
                              const Text('No date range selected'),
                            ] else ...[
                              Text(
                                'Selected Date Range: ${DateFormat.yMMMd().format(selectedDateRange!.start)} - ${DateFormat.yMMMd().format(selectedDateRange!.end)}',
                              ),
                            ],
                            const SizedBox(height: 50),
                            SimpleDateRangePicker(
                              config: SimpleDateRangePickerRange(
                                initialDateRange: null,
                                onChanged: (dates) => setState(
                                  () => selectedDateRange = dates,
                                ),
                              ),
                              style: const SimpleDateRangePickerStyle(
                                colors: SimpleDateRangePickerColors(
                                  backgroundColor: Colors.pink,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'In-line single date picker',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),
                            if (selectedDate == null) ...[
                              const Text('No single date selected'),
                            ] else ...[
                              Text(
                                'Selected Date: ${DateFormat.yMMMd().format(selectedDate!)}',
                              ),
                            ],
                            const SizedBox(height: 50),
                            SimpleDateRangePicker(
                              config: SimpleDateRangePickerSingle(
                                initialDate: null,
                                onChanged: (date) => setState(
                                  () => selectedDate = date,
                                ),
                              ),
                              style: const SimpleDateRangePickerStyle(
                                colors: SimpleDateRangePickerColors(
                                  backgroundColor: Colors.pink,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
