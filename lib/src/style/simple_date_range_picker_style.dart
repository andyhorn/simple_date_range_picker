import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/src/style/simple_date_range_picker_colors.dart';

class SimpleDateRangePickerStyle {
  const SimpleDateRangePickerStyle({
    this.colors,
    this.monthTitleTextStyle,
    this.weekdayTextStyle,
  });

  factory SimpleDateRangePickerStyle.defaults(BuildContext context) {
    return SimpleDateRangePickerStyle(
      colors: SimpleDateRangePickerColors.defaults(context),
      monthTitleTextStyle: Theme.of(context).textTheme.titleMedium,
      weekdayTextStyle: Theme.of(context).textTheme.bodySmall,
    );
  }

  final SimpleDateRangePickerColors? colors;
  final TextStyle? monthTitleTextStyle;
  final TextStyle? weekdayTextStyle;
}
