import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('getNext7Days', () {
    test('1', () {
      expect(DateTimeFormatter.getNext7Days(day: 1, today: 1), 'Mon');
    });
    test('2', () {
      expect(DateTimeFormatter.getNext7Days(day: 2, today: 1), 'Tue');
    });
    test('3', () {
      expect(DateTimeFormatter.getNext7Days(day: 3, today: 1), 'Wed');
    });
    test('4', () {
      expect(DateTimeFormatter.getNext7Days(day: 4, today: 1), 'Thu');
    });
    test('5', () {
      expect(DateTimeFormatter.getNext7Days(day: 5, today: 1), 'Fri');
    });
    test('6', () {
      expect(DateTimeFormatter.getNext7Days(day: 6, today: 1), 'Sat');
    });
    test('7', () {
      expect(DateTimeFormatter.getNext7Days(day: 7, today: 1), 'Sun');
    });
    test('invalid input', () {
      expect(
        () => DateTimeFormatter.getNext7Days(day: 0, today: 1),
        throwsA(
          isA<Exception>(),
        ),
      );
    });
  });

  group('getNextDaysMonth', () {
    test('next day of same month returns same month', () {
      DateTimeFormatter.initNextDay(
        i: 1,
        currentTime: DateTime(2021), // Jan 1 2021
      );

      expect(DateTimeFormatter.getNextDaysMonth(), 'January');
    });
    test('last day of month returns next month', () {
      DateTimeFormatter.initNextDay(
        i: 1,
        currentTime: DateTime(2021, 1, 31), // Jan 31 2021
      );

      expect(DateTimeFormatter.getNextDaysMonth(), 'February');
    });
    test('last day of year returns January', () {
      DateTimeFormatter.initNextDay(
        i: 1,
        currentTime: DateTime(2021, 12, 31), // Dec 31 2021
      );

      expect(DateTimeFormatter.getNextDaysMonth(), 'January');
    });
  });

  group('getNextDaysDate', () {
    test('last day of year returns 1 as String', () {
      DateTimeFormatter.initNextDay(
        i: 1,
        currentTime: DateTime(2021, 12, 31),
      );

      expect(DateTimeFormatter.getNextDaysDate(), 1);
    });
    test('last day of feb returns 1 as String', () {
      DateTimeFormatter.initNextDay(
        i: 1,
        currentTime: DateTime(2021, 2, 28),
      );

      expect(DateTimeFormatter.getNextDaysDate(), 1);
    });
    test('random day mid month returns next day int as String', () {
      DateTimeFormatter.initNextDay(
        i: 1,
        currentTime: DateTime(2021, 4, 5),
      );

      expect(DateTimeFormatter.getNextDaysDate(), 6);
    });
  });

  group('getNextDaysYear', () {
    test('last day of 2021 returns 2022 as String', () {
      DateTimeFormatter.initNextDay(
        i: 1,
        currentTime: DateTime(2021, 12, 31),
      );

      expect(DateTimeFormatter.getNextDaysYear(), '2022');
    });
    test('first day of 2021 returns 2021 as String', () {
      DateTimeFormatter.initNextDay(
        i: 1,
        currentTime: DateTime(2021), // Jan 1 2021
      );

      expect(DateTimeFormatter.getNextDaysYear(), '2021');
    });
  });

  group('formatTimeToHour', () {
    test('midnight DateTime returns 12 AM when timeIs24hrs is false', () {
      final midnight = DateTime(2021); // Jan 1 2021 12AM

      final timeString = DateTimeFormatter.formatTimeToHour(
        time: midnight,
        timeIn24hrs: false,
      );

      /// intl returns control characters so just checking for '11' and 'PM'
      expect(
        timeString.contains('12'),
        true,
      );
      expect(
        timeString.contains('AM'),
        true,
      );
    });

    test('11pm DateTime returns 11 PM when timeIs24hrs is false', () {
      final time = DateTime(2021, 1, 1, 23); // Jan 1 2021 11 PM

      final timeString = DateTimeFormatter.formatTimeToHour(
        time: time,
        timeIn24hrs: false,
      );

      /// intl returns control characters so just checking for '11' and 'PM'
      expect(timeString.contains('11'), true);
      expect(timeString.contains('PM'), true);
    });

    test('11pm or 23:00 DateTime returns 23:00 when timeIs24hrs is true', () {
      final time = DateTime(2021, 1, 1, 23); // Jan 1 2021 11 PM

      expect(
        DateTimeFormatter.formatTimeToHour(
          time: time,
          timeIn24hrs: true,
        ),
        '23:00',
      );
    });

    test('Noon DateTime returns 12:00 when timeIs24hrs is true', () {
      final time = DateTime(2021, 1, 1, 12); // Jan 1 2021 12 PM

      expect(
        DateTimeFormatter.formatTimeToHour(
          time: time,
          timeIn24hrs: true,
        ),
        '12:00',
      );
    });
  });

  group('formatFullTime', () {
    test('midnight DateTime returns 12:00 AM when timeIs24hrs is false', () {
      final midnight = DateTime(2021); // Jan 1 2021 12AM

      final timeString = DateTimeFormatter.formatFullTime(
        time: midnight,
        timeIn24Hrs: false,
      );

      /// intl returns control characters so just checking for '11' and 'PM'
      expect(timeString.contains('12:00'), true);
      expect(timeString.contains('AM'), true);
    });
    test('11pm DateTime returns 11 PM when timeIs24hrs is false', () {
      final midnight = DateTime(2021, 1, 1, 23); // Jan 1 2021 11 PM

      final timeString = DateTimeFormatter.formatFullTime(
        time: midnight,
        timeIn24Hrs: false,
      );

      /// intl returns control characters so just checking for '11' and 'PM'
      expect(timeString.contains('11:00'), true);
      expect(timeString.contains('PM'), true);
    });

    test('11pm or 23:00 DateTime returns 23:00 when timeIs24hrs is true', () {
      final midnight = DateTime(2021, 1, 1, 23); // Jan 1 2021 11 PM

      expect(
        DateTimeFormatter.formatFullTime(
          time: midnight,
          timeIn24Hrs: true,
        ),
        '23:00',
      );
    });

    test('Noon DateTime returns 12:00 when timeIs24hrs is true', () {
      final midnight = DateTime(2021, 1, 1, 12); // Jan 1 2021 11 PM

      expect(
        DateTimeFormatter.formatFullTime(
          time: midnight,
          timeIn24Hrs: true,
        ),
        '12:00',
      );
    });
  });

  group('abbreviateMonth', () {
    test('abbreviateMonth returns 3 or 4 letter abbreviatoins for all months',
        () {
      const jan = 'January';
      const feb = 'February';
      const march = 'March';
      const april = 'April';
      const may = 'May';
      const june = 'June';
      const july = 'July';
      const august = 'August';
      const sep = 'September';
      const oct = 'October';
      const nov = 'November';
      const dec = 'December';

      expect(DateTimeFormatter.abbreviateMonth(month: jan), 'Jan');
      expect(DateTimeFormatter.abbreviateMonth(month: feb), 'Feb');
      expect(DateTimeFormatter.abbreviateMonth(month: march), 'Mar');
      expect(DateTimeFormatter.abbreviateMonth(month: april), 'Apr');
      expect(DateTimeFormatter.abbreviateMonth(month: may), 'May');
      expect(DateTimeFormatter.abbreviateMonth(month: june), 'June');
      expect(DateTimeFormatter.abbreviateMonth(month: july), 'July');
      expect(DateTimeFormatter.abbreviateMonth(month: august), 'Aug');
      expect(DateTimeFormatter.abbreviateMonth(month: sep), 'Sep');
      expect(DateTimeFormatter.abbreviateMonth(month: oct), 'Oct');
      expect(DateTimeFormatter.abbreviateMonth(month: nov), 'Nov');
      expect(DateTimeFormatter.abbreviateMonth(month: dec), 'Dec');
    });

    test('invalid input', () {
      const badInput = '';
      expect(
        () => DateTimeFormatter.abbreviateMonth(month: badInput),
        throwsA(
          isA<Exception>(),
        ),
      );
    });
  });
}
