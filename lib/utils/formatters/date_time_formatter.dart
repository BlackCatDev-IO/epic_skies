import 'package:intl/intl.dart';

class DateTimeFormatter {
  static late int _today;
  static late int _day;
  static late int _month;
  static late DateTime _nextDay;

  static final _format12hr = DateFormat.j();
  static final _format24hr = DateFormat.H();
  static final _formatMonthAbbreviation = DateFormat.MMM();
  static final _formatFullTime12hr = DateFormat.jm();
  static final _formatFullTime24hr = DateFormat.Hm();

  static void initNextDay({
    required int i,
    required DateTime currentTime,
  }) {
    _nextDay = currentTime.add(Duration(days: i));
  }

  static String getNextDaysMonth() {
    _month = _nextDay.month;
    return _getMonth(_month);
  }

  static int getNextDaysDate() => _nextDay.day;

  static String getNextDaysYear() => _nextDay.year.toString();

  static String getNext7Days({required int day, required int today}) {
    _day = _getNextDayCode(day: day, today: today);
    if (_day > 7) {
      _day -= 7;
    }

    return switch (_day) {
      1 => 'Mon',
      2 => 'Tue',
      3 => 'Wed',
      4 => 'Thu',
      5 => 'Fri',
      6 => 'Sat',
      7 => 'Sun',
      _ => throw Exception(
          '''
Unexpected value returned from _getNextDayCode method in DateTimeFormatter''',
        )
    };
  }

  static String _getMonth(int i) {
    return switch (i) {
      1 => 'January',
      2 => 'February',
      3 => 'March',
      4 => 'April',
      5 => 'May',
      6 => 'June',
      7 => 'July',
      8 => 'August',
      9 => 'September',
      10 => 'October',
      11 => 'November',
      12 => 'December',
      _ => throw Exception(
          '''
Unexpected value sent to _getMonth method in DateTimeFormatter. Should only be 1-12''',
        )
    };
  }

  static int _getNextDayCode({required int day, required int today}) {
    _today = today;

    if (day == _today) {
      return _today;
    } else if (day < 8) {
      return day;
    } else {
      return day - 7;
    }
  }

  static String formatTime({
    required DateTime time,
    required bool timeIn24Hrs,
    bool roundToHour = true,
  }) {
    if (timeIn24Hrs) {
      return roundToHour
          ? '${_format24hrTime(time)}:00'
          : formatFullTime(time: time, timeIn24Hrs: timeIn24Hrs);
    }

    return roundToHour
        ? _format12hrTime(time)
        : formatFullTime(time: time, timeIn24Hrs: timeIn24Hrs);
  }

  static String formatTimeToHour({
    required DateTime time,
    required bool timeIn24hrs,
  }) {
    if (timeIn24hrs) {
      return '${_format24hrTime(time)}:00';
    } else {
      return _format12hrTime(time);
    }
  }

  static String formatFullTime({
    required DateTime time,
    required bool timeIn24Hrs,
  }) {
    if (timeIn24Hrs) {
      return _formateFullTime24hr(time);
    } else {
      return _formateFullTime12hr(time);
    }
  }

  static String _formateFullTime12hr(DateTime time) =>
      _formatFullTime12hr.format(time);

  static String _formateFullTime24hr(DateTime time) =>
      _formatFullTime24hr.format(time);

  static String _format24hrTime(DateTime time) => _format24hr.format(time);

  static String _format12hrTime(DateTime time) => _format12hr.format(time);

  static String getMonthAbbreviation({required DateTime time}) =>
      _formatMonthAbbreviation.format(time);

  static String abbreviateMonth({required String month}) {
    return switch (month.toLowerCase()) {
      'january' => 'Jan',
      'february' => 'Feb',
      'march' => 'Mar',
      'april' => 'Apr',
      'may' => 'May',
      'june' => 'June',
      'july' => 'July',
      'august' => 'Aug',
      'september' => 'Sep',
      'october' => 'Oct',
      'november' => 'Nov',
      'december' => 'Dec',
      _ => throw Exception('abbreviateMonth function invalid input')
    };
  }

  static String formatAlertTime(DateTime time) {
    return DateFormat('hh:mm a, EEEE, MMMM d').format(time);
  }
}
