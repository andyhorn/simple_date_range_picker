import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/src/style/simple_date_range_picker_colors.dart';

class SimpleDateRangePickerStyle {
  const SimpleDateRangePickerStyle({
    this.colors,
  });

  factory SimpleDateRangePickerStyle.defaults(BuildContext context) {
    return SimpleDateRangePickerStyle(
      colors: SimpleDateRangePickerColors.defaults(context),
    );
  }

  final SimpleDateRangePickerColors? colors;
}
