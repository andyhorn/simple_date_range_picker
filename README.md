# SimpleDateRangePicker

A simple, stylish, and customizable date picker component for Flutter.

## Features

* Select a single date, multiple dates, or a date range (`DateTimeRange`)
* Highly customizable colors, borders, and TextStyles

![Date range picker with a date range selected](https://github.com/andyhorn/simple_date_range_picker/raw/main/documentation/images/date_range_picker_selected.png)

## Getting started

Install the package by adding it to your `pubspec.yaml` file.

```yaml
dependencies:
  simple_date_range_picker: <latest version>
```

## Usage

### Import

Import the package into your project:

```dart
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
```

### Picker Widget

Use the `SimpleDateRangePicker` widget to display the picker as an in-line widget:

Use the `config` property to control the behavior of the widget. To select a `DateTimeRange`, use the `SimpleDateRangePickerRange`; for a single `DateTime`, use `SimpleDateRangePickerSingle`; for multiple dates (`List<DateTime>`), use `SimpleDateRangePickerMulti`:

```dart
// DateTimeRange
SimpleDateRangePicker(
  config: SimpleDateRangePickerRange(
    initialDateRange: null,
    onChanged: (dateRange) => setState(() => selectedDateRange = dateRange),
  ),
),

// DateTime
SimpleDateRangePicker(
  config: SimpleDateRangePickerSingle(
    initialDate: null,
    onChanged: (dateTime) => setState(() => selectedDate = dateTime),
  ),
),

// List<DateTime>
SimpleDateRangePicker(
  config: SimpleDateRangePickerMulti(
    initialDates: null,
    onChanged: (dateList) => setState(() => selectedDates = dateList)
  ),
),
```

### Picker Dialog

It's more likely that you'll want to display one of these pickers in a dialog. For this, you can use one of the provided functions: `showSimpleDateRangePickerDialog`, `showSimpleDatePickerDialog`, and `showSimpleMultiDatePickerDialog`.

```dart
final DateTimeRange? dateRange = await showSimpleDateRangePickerDialog(context);

final DateTime? date = await showSimpleDatePickerDialog(context);

final List<DateTime>? dates = await showSimpleMultiDatePickerDialog(context);
```

### Customization

#### Styles

Aside from a config class for changing the picker's behavior, the picker styles are also highly customizable.

The `SimpleDateRangePicker` widget exposes a styling API that uses the `SimpleDateRangePickerStyle` and the `SimpleDateRangePickerColors` classes.

```dart
class SimpleDateRangePickerColors {
  ...
  final Color backgroundColor;
  final Color foregroundColor;
  final double boundaryOpacity;
  final double hoveredOpacity;
  final double selectedOpacity;
  ...
}
```

This class determines the background and foreground colors of the selected dates in the picker. The three opacities are:

  * `boundaryOpacity` - the opacity of the first and last dates in the selected range (the "boundaries")
  * `hoveredOpacity` - the opacity of the date actively hovered over by the user
  * `selectedOpacity` - the opacity of all other dates in the selected range

By default, `hoveredOpacity > boundaryOpacity > selectedOpacity`, but this is entirely up to you.

The `SimpleDateRangePickerStyle` contains the colors, as well as other styling options for the picker:

```dart
class SimpleDateRangePickerStyle {
  final SimpleDateRangePickerColors? colors;
  final TextStyle? monthTitleTextStyle;
  final TextStyle? weekdayTextStyle;
  final TextStyle? dayTextStyle;
  final Radius? activeItemRadius;
  final ButtonStyle? nextIconButtonStyle;
  final ButtonStyle? previousIconButtonStyle;
}
```

Using this class, you can customize the style of almost every component within the picker.

For example, to change the background color of the picker to red, the foreground color to white, and the selected-date border radius to zero:

```dart
SimpleDateRangePicker(
  style: SimpleDateRangePickerStyle(
    colors: SimpleDateRangePickerColors(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
    activeItemRadius: Radius.zero,
  ),
  config: SimpleDateRangePickerRange(
    initialDateRange: null,
    onChanged: (dateRange) => setState(() => selectedDates = dateRange),
  ),
),
```

## Roadmap

Additional features planned for the future include:

* ~~Customizable colors, borders, and TextStyles for the picker~~
* ~~Customizable colors, border, TextStyles, and buttons for the dialog~~
* ~~Single date selection~~
* ~~Multi-date selection~~
* ~~Date validation - determine which dates are selectable~~

