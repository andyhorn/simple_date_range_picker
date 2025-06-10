## 1.0.1

Fix linter warnings after Flutter upgrade

## 1.0.0

Stable release!
Added a multi-day picker config and launcher function.
Added the ability to "disable" a day from selection.

## 0.0.8

Fix a bug in the initial date detection and display logic.

## 0.0.7

Fix an overflow issue only appearing in tests.

## 0.0.6

Attempt to fix release workflow file (again).

## 0.0.5

Add a `showSimpleDatePickerDialog` function for selecting a single date in a dialog.

## 0.0.4

Add behavior customization API.

Use `SimpleDateRangePickerRange` or `SimpleDateRangePickerSingle` config classes to control whether the picker allows selecting a range of dates or a single date.

Depending on which config class is used, the picker will return a `DateTimeRange?` or a `DateTime?`.

## 0.0.3

Add styling customization API.

  * Set background & foreground color for selected dates
  * Set TextStyle of the month title
  * Set TextStyle of the weekday labels
  * Set TextStyle of date grid labels
  * Set ButtonStyles for the previous/next IconButtons
  * Set background color for the dialog
  * Set ButtonStyles for the cancel/confirm buttons in the dialog

## 0.0.2

Relax SDK constraint

## 0.0.1

Initial release

* Basic functionality
  * Select a range of dates
  * Inline widget
  * Dialog
