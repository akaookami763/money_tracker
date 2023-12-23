/**
 * Small class declaration to return params for a date picker
 */
class DatePickerParams {
  DateTime firstDate;
  DateTime lastDate;
  DateTime initialDate;

  DatePickerParams(this.firstDate, this.lastDate, this.initialDate);
}

DatePickerParams getPickerDates(DateTime selectedDate) {
  final today = DateTime.now();
  final firstDate = DateTime(today.year - 1);
  return DatePickerParams(firstDate, today, selectedDate);
}
