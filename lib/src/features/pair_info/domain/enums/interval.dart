enum PointInterval {
  fiveMins,
  fifteenMins,
  oneHour,
  twoHours,
  oneDay,
  oneWeek,
  oneMonth;

  String get value {
    return switch (this) {
      PointInterval.fiveMins => '5min',
      PointInterval.fifteenMins => '15min',
      PointInterval.oneHour => '1h',
      PointInterval.twoHours => '2h',
      PointInterval.oneDay => '1day',
      PointInterval.oneWeek => '1week',
      PointInterval.oneMonth => '1month',
    };
  }
}
