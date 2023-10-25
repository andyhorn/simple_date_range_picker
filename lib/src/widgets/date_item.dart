import 'package:flutter/material.dart';
import 'package:simple_date_range_picker/src/selection_type.dart';

class DateItem extends StatefulWidget {
  const DateItem({
    super.key,
    required this.date,
    required this.selected,
    required this.type,
    required this.onSelected,
  });

  final DateTime date;
  final bool selected;
  final SelectionType type;
  final VoidCallback onSelected;

  @override
  State<DateItem> createState() => _DateItemState();
}

class _DateItemState extends State<DateItem> {
  static const boundaryOpacity = 0.3;
  static const hoveredOpacity = 0.4;
  static const selectedOpacity = 0.2;
  static const radius = Radius.circular(4);

  var hovered = false;

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
                left: switch (widget.type) {
                  SelectionType.none => Radius.zero,
                  SelectionType.end => Radius.zero,
                  SelectionType.middle => Radius.zero,
                  SelectionType.single => radius,
                  SelectionType.start => radius,
                },
                right: switch (widget.type) {
                  SelectionType.none => Radius.zero,
                  SelectionType.end => radius,
                  SelectionType.middle => Radius.zero,
                  SelectionType.single => radius,
                  SelectionType.start => Radius.zero,
                },
              ),
              color: _getColor(),
            ),
            child: Center(
              child: Text(
                '${widget.date.day}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color? _getColor() {
    final baseColor = Theme.of(context).colorScheme.primary;

    switch (widget.type) {
      // add color if hovered, otherwise no color
      case SelectionType.none:
        return hovered ? baseColor.withOpacity(hoveredOpacity) : null;
      // use the "selected" opacity when not hovered
      case SelectionType.middle:
        return baseColor.withOpacity(
          hovered ? hoveredOpacity : selectedOpacity,
        );
      // use the "boundary" opacity when not hovered
      case SelectionType.end:
      case SelectionType.start:
      case SelectionType.single:
        return baseColor.withOpacity(
          hovered ? hoveredOpacity : boundaryOpacity,
        );
    }
  }
}
