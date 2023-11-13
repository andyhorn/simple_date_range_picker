import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
import 'package:simple_date_range_picker/src/constants/constants.dart';
import 'package:simple_date_range_picker/src/date_selection_type.dart';

class DateItem extends StatefulWidget {
  const DateItem({
    super.key,
    required this.date,
    required this.selected,
    required this.type,
    required this.onSelected,
    this.style,
  });

  final DateTime date;
  final bool selected;
  final DateSelectionType type;
  final VoidCallback onSelected;
  final SimpleDateRangePickerStyle? style;

  @override
  State<DateItem> createState() => _DateItemState();
}

class _DateItemState extends State<DateItem> {
  var hovered = false;

  SimpleDateRangePickerColors get colors {
    return widget.style?.colors ??
        SimpleDateRangePickerStyle.defaults(context).colors!;
  }

  Radius get radius {
    return widget.style?.activeItemRadius ?? Constants.defaultDateItemRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hovered = true),
        onExit: (_) => setState(() => hovered = false),
        child: GestureDetector(
          onTap: () => widget.onSelected(),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: _getLeftBorderRadius(),
                right: _getRightBorderRadius(),
              ),
              color: _getBackgroundColor(),
            ),
            child: Center(
              child: Text(
                '${widget.date.day}',
                textAlign: TextAlign.center,
                style: _getTextStyle(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color? _getBackgroundColor() {
    return colors.getBackgroundColor(
      isSelected: widget.type != DateSelectionType.none,
      isHovered: hovered,
      isStartOrEndDate: widget.type == DateSelectionType.start ||
          widget.type == DateSelectionType.end,
    );
  }

  TextStyle _getTextStyle() {
    final baseStyle = widget.style?.dayTextStyle ?? const TextStyle();

    if (hovered) {
      return baseStyle.copyWith(color: colors.foregroundColor);
    }

    return switch (widget.type) {
      DateSelectionType.none => baseStyle,
      _ => baseStyle.copyWith(color: colors.foregroundColor),
    };
  }

  Radius _getRightBorderRadius() {
    if (hovered) {
      return radius;
    }

    return switch (widget.type) {
      DateSelectionType.none => Radius.zero,
      DateSelectionType.end => radius,
      DateSelectionType.middle => Radius.zero,
      DateSelectionType.single => radius,
      DateSelectionType.start => Radius.zero,
    };
  }

  Radius _getLeftBorderRadius() {
    if (hovered) {
      return radius;
    }

    return switch (widget.type) {
      DateSelectionType.none => Radius.zero,
      DateSelectionType.end => Radius.zero,
      DateSelectionType.middle => Radius.zero,
      DateSelectionType.single => radius,
      DateSelectionType.start => radius,
    };
  }
}
