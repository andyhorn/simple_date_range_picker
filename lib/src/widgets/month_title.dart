import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    super.key,
    required this.month,
  });

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.yMMMM().format(month),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
