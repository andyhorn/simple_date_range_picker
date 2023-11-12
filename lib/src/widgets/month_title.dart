import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    super.key,
    required this.month,
    this.textStyle,
  });

  final DateTime month;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.yMMMM().format(month),
      style: textStyle ?? Theme.of(context).textTheme.titleMedium,
    );
  }
}
