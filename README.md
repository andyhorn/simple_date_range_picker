# SimpleDateRangePicker

A simple, stylish `DateTimeRange` picker component for Flutter.

**Note:** This package is under active development and may change significantly between versions. Once a stable implementation is reached, the package will be bumped to version 1.0.0.

## Features

* In-line widget for selecting a range of dates (`DateTimeRange`) or a single date (`DateTime`)
* `showSimpleDateRangePickerDialog` method to easily display the picker in a dialog
* Highly customizable colors, borders, and TextStyles

![Date range picker with a date range selected](https://github.com/andyhorn/simple_date_range_picker/raw/main/documentation/images/date_range_picker_selected.png)

## Getting started

Install the package by adding it to your `pubspec.yaml` file.

```yaml
dependencies:
  simple_date_range_picker: ^0.0.4
```

## Usage

Import the package into your project:

```dart
import 'package:simple_date_range_picker/simple_date_range_picker.dart';
```

Use the `SimpleDateRangePicker` widget to display the picker as an in-line widget:

```dart
SimpleDateRangePicker(
  config: SimpleDateRangePickerRange(
    initialDateRange: null,
    onChanged: (dateRange) => setState(() => selectedDates = dateRange),
  ),
),
```

Or, use `showSimpleDateRangePickerDialog` to display the picker as a modal dialog:

```dart
final dateRange = await showSimpleDateRangePickerDialog(context);
```

### Customization

#### Behavior

The behavior of the picker is configurable using one of two config classes:

##### Date range

To select a date range, use the `SimpleDateRangePickerRange` config class.

```dart
  SimpleDateRangePicker(
    config: SimpleDateRangePickerRange(
      initialDateRange: null,
      onChanged: (dateRange) => setState(() => selectedDates = dateRange),
    ),
  ),
```

In this example, the `onChanged` method will return a `DateTimeRange?` value.

##### Single date

To select a single date, use the `SimpleDateRangePickerSingle` config class.

```dart
  SimpleDateRangePicker(
    config: SimpleDateRangePickerSingle(
      initialDate: null,
      onChanged: (date) => setState(() => selectedDate = date),
    ),
  ),
```

In this example, the `onChanged` method will return a `DateTime?` value.

#### Styles

The `SimpleDateRangePicker` exposes a styling API that uses the `SimpleDateRangePickerStyle` and the `SimpleDateRangePickerColors` classes.

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

The `SimpleDateRangePickerStyle` contains the colors, as well as other styles for the picker:

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

Using this class, you can customize the style of almost every component within te picker.

For example, to change the background color of the picker to red, the foreground color to white, and selected date border radius to zero:

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
* Date validation - determine which dates are selectable
* Custom initial month view - specify which month to display first
