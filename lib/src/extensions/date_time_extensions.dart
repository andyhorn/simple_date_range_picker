extension DateTimeExtensions on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime startOfDay() {
    return DateTime(year, month, day);
  }
}
