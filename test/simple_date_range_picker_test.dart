import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_date_range_picker/simple_date_range_picker.dart';

class TestWrapper extends StatelessWidget {
  const TestWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }
}

void main() {
  testWidgets('smoke test', (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
        child: SimpleDateRangePicker(
          config: SimpleDateRangePickerRange(
            initialDateRange: null,
            onChanged: (dates) {},
          ),
        ),
      ),
    );

    expect(find.byType(SimpleDateRangePicker), findsOneWidget);
  });

  testWidgets('Displays month title', (widgetTester) async {
    await widgetTester.pumpWidget(
      TestWrapper(
        child: SimpleDateRangePicker(
          config: SimpleDateRangePickerRange(
            onChanged: (dates) {},
            initialDateRange: DateTimeRange(
              start: DateTime(2023, 10, 1),
              end: DateTime(2023, 10, 5),
            ),
          ),
        ),
      ),
    );

    expect(find.text('October 2023'), findsOneWidget);
  });

  testWidgets('Emits selected date range', (widgetTester) async {
    DateTimeRange? dateRange;

    await widgetTester.pumpWidget(
      TestWrapper(
        child: SimpleDateRangePicker(
          config: SimpleDateRangePickerRange(
            initialDateRange: null,
            onChanged: (dates) => dateRange = dates,
          ),
        ),
      ),
    );

    await widgetTester.tap(find.text('1'));
    await widgetTester.pump();

    await widgetTester.tap(find.text('5'));
    await widgetTester.pump();

    expect(
      dateRange,
      equals(
        DateTimeRange(
          start: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            1,
          ),
          end: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            5,
          ),
        ),
      ),
    );
  });
}
