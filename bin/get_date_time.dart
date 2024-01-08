bool checkDayAndTimeMatch({
  required int scheduledTimeInt,
  required List<int> scheduledWeekdaysIntList,
}) {
  DateTime getCurrentTime() {
    return DateTime.now();
  }

  int getCurrentWeekday() {
    return DateTime.now().weekday;
  }

  if (getCurrentTime().hour == scheduledTimeInt &&
      scheduledWeekdaysIntList.contains(getCurrentWeekday())) {
    return true;
  } else {
    return false;
  }
}
