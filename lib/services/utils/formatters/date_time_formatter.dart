import 'package:epic_skies/controllers/current_weather_controller.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {
  static late int _today, _month, _day;
  static late DateTime _nextDay;

  static final _format12hr = DateFormat.j();
  static final _format24hr = DateFormat.H();
  static final _formatMonthAbbreviation = DateFormat.MMM();
  static final _formatFullTime12hr = DateFormat.jm();
  static final _formatFullTime24hr = DateFormat.Hm();

  static void initNextDay(int i) {
    _nextDay = CurrentWeatherController.to.currentTime.add(Duration(days: i));
  }

  static String getNextDaysMonth() {
    _month = _nextDay.month;
    return _getMonth(_month);
  }

  static String getNextDaysDate() => _nextDay.day.toString();

  static String getNextDaysYear() => _nextDay.year.toString();

  static String getNext7Days(int i) {
    _day = _getNextDayCode(i);
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
            'Unexpected value returned from _getNextDayCode method in DateTimeFormatter');
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
        return '';
    }
  }

  static int _getNextDayCode(int day) {
    _today = CurrentWeatherController.to.currentTime.weekday;

    if (day == _today) {
      return _today;
    } else if (day < 8) {
      return day;
    } else {
      return day - 7;
    }
  }

  static String formatTimeToHour({required DateTime time}) {
    final timeIs24Hrs =
        StorageController.to.settingsMap[timeIs24HrsKey]! as bool;
    if (timeIs24Hrs) {
      return '${_format24hrTime(time)}:00';
    } else {
      return _format12hrTime(time);
    }
  }

  static String formatFullTime({required DateTime time}) {
    final timeIs24Hrs =
        StorageController.to.settingsMap[timeIs24HrsKey]! as bool;
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
      case 'May':
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
        throw 'abbreviateMonth function invalid input';
    }
  }
}
