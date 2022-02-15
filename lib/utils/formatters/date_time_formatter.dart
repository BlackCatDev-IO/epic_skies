import 'package:intl/intl.dart';

class DateTimeFormatter {
  static late int _today, _month, _day;
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

  static String getNextDaysDate() => _nextDay.day.toString();

  static String getNextDaysYear() => _nextDay.year.toString();

  static String getNext7Days({required int day, required int today}) {
    _day = _getNextDayCode(day: day, today: today);
    if (_day > 7) {
      _day -= 7;
    }
    switch (_day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        throw Exception(
          'Unexpected value returned from _getNextDayCode method in DateTimeFormatter',
        );
    }
  }

  static String _getMonth(int i) {
    switch (i) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        throw Exception(
          'Unexpected value sent to _getMonth method in DateTimeFormatter. Should only be 1-12',
        );
    }
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
    required bool timeIs24Hrs,
  }) {
    if (timeIs24Hrs) {
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
    switch (month.toLowerCase()) {
      case 'january':
        return 'Jan';
      case 'february':
        return 'Feb';
      case 'march':
        return 'Mar';
      case 'april':
        return 'Apr';
      case 'may':
        return 'May';
      case 'june':
        return 'June';
      case 'july':
        return 'July';
      case 'august':
        return 'Aug';
      case 'september':
        return 'Sep';
      case 'october':
        return 'Oct';
      case 'november':
        return 'Nov';
      case 'december':
        return 'Dec';

      default:
        throw Exception('abbreviateMonth function invalid input');
    }
  }
}
