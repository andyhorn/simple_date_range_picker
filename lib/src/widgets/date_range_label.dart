import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeLabel extends StatelessWidget {
  const DateRangeLabel({
    super.key,
    required this.endDate,
    required this.startDate,
  });

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (startDate != null) ...[
          Text(
            DateFormat.yMMMMd().format(startDate!),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
        if (startDate != null && endDate != null) ...[
          const Text(' - '),
        ],
        if (endDate != null) ...[
          Text(
            DateFormat.yMMMMd().format(endDate!),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ],
    );
  }
}
