import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
import 'package:simple_date_range_picker/src/constants/constants.dart';
import 'package:simple_date_range_picker/src/selection_type.dart';

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
  final SelectionType type;
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
              color: _getColor(),
            ),
            child: Center(
              child: Text(
                '${widget.date.day}',
                textAlign: TextAlign.center,
                style: widget.style?.dayTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color? _getColor() {
    return colors.getColor(
      isSelected: widget.type != SelectionType.none,
      isHovered: hovered,
      isStartOrEndDate: widget.type == SelectionType.start ||
          widget.type == SelectionType.end,
    );
  }

  Radius _getRightBorderRadius() {
    if (hovered) {
      return radius;
    }

    return switch (widget.type) {
      SelectionType.none => Radius.zero,
      SelectionType.end => radius,
      SelectionType.middle => Radius.zero,
      SelectionType.single => radius,
      SelectionType.start => Radius.zero,
    };
  }

  Radius _getLeftBorderRadius() {
    if (hovered) {
      return radius;
    }

    return switch (widget.type) {
      SelectionType.none => Radius.zero,
      SelectionType.end => Radius.zero,
      SelectionType.middle => Radius.zero,
      SelectionType.single => radius,
      SelectionType.start => radius,
    };
  }
}
