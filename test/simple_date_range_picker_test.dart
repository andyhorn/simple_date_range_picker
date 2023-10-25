import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_date_range_picker/simple_date_range_picker.dart';

void main() {
  testWidgets('$SimpleDateRangePicker', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SimpleDateRangePicker(
              onChanged: (dates) {},
            ),
          ),
        ),
      ),
    );

    expect(find.byType(SimpleDateRangePicker), findsOneWidget);
  });
}
