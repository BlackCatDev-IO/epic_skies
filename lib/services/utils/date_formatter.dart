import 'package:flutter/foundation.dart';

class DateFormatter {
  int _today, _month, _day;
  DateTime _nextDay;

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
    switch (_day) {
      case 1:
        return 'Mon';
        break;
      case 2:
        return 'Tue';
        break;

      case 3:
        return 'Wed';
        break;

      case 4:
        return 'Thu';
        break;

      case 5:
        return 'Fri';
        break;

      case 6:
        return 'Sat';
        break;

      case 7:
        return 'Sun';
        break;

      default:
        return '';
    }
  }

  String _getMonth(int i) {
    switch (i) {
      case 1:
        return 'January';
        break;
      case 2:
        return 'February';
        break;
      case 3:
        return 'March';
        break;
      case 4:
        return 'April';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'June';
        break;
      case 7:
        return 'July';
        break;
      case 8:
        return 'August';
        break;
      case 9:
        return 'September';
        break;
      case 10:
        return 'October';
        break;
      case 11:
        return 'November';
        break;
      case 12:
        return 'December';
        break;
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

  String format12hrTime({int hour}) {
    int nextHour = hour + 1;
    String amPm = _formatAmPm(hour);

    if (nextHour > 12 && nextHour <= 24) {
      nextHour -= 12;
    } else if (nextHour > 24 && nextHour < 36) {
      nextHour -= 24;
    } else if (nextHour >= 36) {
      nextHour -= 36;
    }

    return '$nextHour:00 $amPm';
  }

  String _formatAmPm(int hour) {
    if (hour >= 0 && hour <= 10) {
      return 'AM';
    } else if (hour >= 11 && hour <= 22) {
      return 'PM';
    } else if (hour >= 23 && hour <= 35) {
      return 'AM';
    } else
      return 'PM';
  }
}
