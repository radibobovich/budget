class DateRange {
  final DateTime start;
  final DateTime end;

  DateRange(this.start, this.end);

  bool isInRange(DateTime date) {
    return date.millisecondsSinceEpoch > start.millisecondsSinceEpoch &&
        date.millisecondsSinceEpoch < end.millisecondsSinceEpoch;
  }

  DateRange copyWith({DateTime? start, DateTime? end}) {
    return DateRange(start ?? this.start, end ?? this.end);
  }
}
