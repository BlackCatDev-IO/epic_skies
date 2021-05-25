import 'package:intl/intl.dart';

class DateTimeFormatter {
  late int _today, _month, _day;
  late DateTime _nextDay;

  final _format12hr = DateFormat.j();
  final _format24hr = DateFormat.H();
  final _formatFullTime12hr = DateFormat.jm();
  final _formatFullTime24hr = DateFormat.Hm();

  void initNextDay(int i) =>
      _nextDay = DateTime.now().add(Duration(days: i + 1));

  String getNextDaysMonth() {
    _month = _nextDay.month;
    return _getMonth(_month);
  }

  String getNextDaysDate() => _nextDay.day.toString();

  String getNextDaysYear() => _nextDay.year.toString();

  String getNext7Days(int i) {
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

  String _getMonth(int? i) {
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

  int _getNextDayCode(int day) {
    _today = DateTime.now().weekday;
    if (day == _today) {
      return _today;
    } else if (day < 8) {
      return day;
    } else {
      return day - 7;
    }
  }

  String formatTimeToHour({required DateTime time, required bool timeIs24Hrs}) {
    if (timeIs24Hrs) {
      return '${_format24hrTime(time)}:00';
    } else {
      return _format12hrTime(time);
    }
  }

  String formatFullTime({required DateTime time, required bool timeIs24Hrs}) {
    if (timeIs24Hrs) {
      return _formateFullTime24hr(time);
    } else {
      return _formateFullTime12hr(time);
    }
  }

  String _formateFullTime12hr(DateTime time) =>
      _formatFullTime12hr.format(time);

  String _formateFullTime24hr(DateTime time) =>
      _formatFullTime24hr.format(time);

  String _format24hrTime(DateTime time) => _format24hr.format(time);

  String _format12hrTime(DateTime time) => _format12hr.format(time);
}
