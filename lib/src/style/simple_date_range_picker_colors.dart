import 'package:flutter/material.dart';

class SimpleDateRangePickerColors {
  static const _boundaryOpacity = 0.65;
  static const _hoveredOpacity = 0.8;
  static const _selectedOpacity = 0.5;

  const SimpleDateRangePickerColors({
    required this.backgroundColor,
    required this.foregroundColor,
    this.boundaryOpacity = _boundaryOpacity,
    this.hoveredOpacity = _hoveredOpacity,
    this.selectedOpacity = _selectedOpacity,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final double boundaryOpacity;
  final double hoveredOpacity;
  final double selectedOpacity;

  factory SimpleDateRangePickerColors.defaults(BuildContext context) {
    return SimpleDateRangePickerColors(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  Color? getBackgroundColor({
    required bool isSelected,
    required bool isHovered,
    required bool isStartOrEndDate,
  }) {
    if (!isSelected && !isHovered) {
      return null;
    }

    return backgroundColor.withValues(
        alpha: _getOpacity(
      isHovered: isHovered,
      isSelected: isSelected,
      isStartOrEndDate: isStartOrEndDate,
    ));
  }

  double _getOpacity({
    required bool isHovered,
    required bool isSelected,
    required bool isStartOrEndDate,
  }) {
    if (isHovered) {
      return hoveredOpacity;
    }

    if (isStartOrEndDate) {
      return boundaryOpacity;
    }

    return selectedOpacity;
  }
}
