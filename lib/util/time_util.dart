String getTimeDuration(String comTime) {
  var nowTime = DateTime.now();
  var compareTime = DateTime.parse(comTime);
  if (nowTime.isAfter(compareTime)) {
    if (nowTime.year == compareTime.year) {
      if (nowTime.month == compareTime.month) {
        if (nowTime.day == compareTime.day) {
          if (nowTime.hour == compareTime.hour) {
            if (nowTime.minute == compareTime.minute) {
              return '片刻之间';
            }
            return (nowTime.minute - compareTime.minute).toString() + '分钟前';
          }
          return (nowTime.hour - compareTime.hour).toString() + '小时前';
        }
        return (nowTime.day - compareTime.day).toString() + '天前';
      }
      return (nowTime.month - compareTime.month).toString() + '月前';
    }
    return (nowTime.year - compareTime.year).toString() + '年前';
  }
  return 'time error';
}

/// 获取日期星期几
String getWeekDay(String date) {
  DateTime dateTime = DateTime.parse(date);
  List<String> weekDay = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
  return '${weekDay[dateTime.weekday - 1]}';
}

/// 获取日期是几号
String getDay(String date) {
  DateTime dateTime = DateTime.parse(date);
  String day = dateTime.day.toString();
  return day.length < 2 ? '0$day' : day;
}

/// 获取日期是几月
String getMonth(String date) {
  DateTime dateTime = DateTime.parse(date);
  List<String> months = [
    "一月",
    "二月",
    "三月",
    "四月",
    "五月",
    "六月",
    "七月",
    "八月",
    "九月",
    "十月",
    "十一月",
    "十二月"
  ];
  return '${months[dateTime.month - 1]}';
}

String formatDateStr(String date) {
  DateTime dateTime = DateTime.parse(date);
  return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
}
