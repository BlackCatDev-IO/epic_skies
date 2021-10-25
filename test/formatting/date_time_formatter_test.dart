import 'package:epic_skies/controllers/current_weather_controller.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/formatters/date_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../test_utils.dart';

Future<void> main() async {
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    Get.put(StorageController());
    await StorageController.to.initAllStorage();
    Get.put(CurrentWeatherController());
    CurrentWeatherController.to.currentTime = DateTime.now();
  });
  group('getNext7Days', () {
    test('1', () {
      expect(DateTimeFormatter.getNext7Days(1), 'Mon');
    });
    test('2', () {
      expect(DateTimeFormatter.getNext7Days(2), 'Tue');
    });
    test('3', () {
      expect(DateTimeFormatter.getNext7Days(3), 'Wed');
    });
    test('4', () {
      expect(DateTimeFormatter.getNext7Days(4), 'Thu');
    });
    test('5', () {
      expect(DateTimeFormatter.getNext7Days(5), 'Fri');
    });
    test('6', () {
      expect(DateTimeFormatter.getNext7Days(6), 'Sat');
    });
    test('7', () {
      expect(DateTimeFormatter.getNext7Days(7), 'Sun');
    });
    test('invalid input', () {
      expect(
        () => DateTimeFormatter.getNext7Days(0),
        throwsA(
          isA<Exception>(),
        ),
      );
    });
  });

  group('getNextDaysMonth', () {
    test('next day of same month returns same month', () {
      CurrentWeatherController.to.currentTime = DateTime(2021); // Jan 1 2021
      DateTimeFormatter.initNextDay(1);

      expect(DateTimeFormatter.getNextDaysMonth(), 'January');
    });
    test('last day of month returns next month', () {
      CurrentWeatherController.to.currentTime =
          DateTime(2021, 1, 31); // Jan 31 2021
      DateTimeFormatter.initNextDay(1);

      expect(DateTimeFormatter.getNextDaysMonth(), 'February');
    });
    test('last day of year returns January', () {
      CurrentWeatherController.to.currentTime =
          DateTime(2021, 12, 31); // Dec 31 2021
      DateTimeFormatter.initNextDay(1);

      expect(DateTimeFormatter.getNextDaysMonth(), 'January');
    });
  });

  group('getNextDaysDate', () {
    test('last day of year returns 1 as String', () {
      CurrentWeatherController.to.currentTime = DateTime(2021, 12, 31);
      DateTimeFormatter.initNextDay(1);

      expect(DateTimeFormatter.getNextDaysDate(), '1');
    });
    test('last day of feb returns 1 as String', () {
      CurrentWeatherController.to.currentTime = DateTime(2021, 2, 28);
      DateTimeFormatter.initNextDay(1);

      expect(DateTimeFormatter.getNextDaysDate(), '1');
    });
    test('random day mid month returns next day int as String', () {
      CurrentWeatherController.to.currentTime = DateTime(2021, 4, 5);
      DateTimeFormatter.initNextDay(1);

      expect(DateTimeFormatter.getNextDaysDate(), '6');
    });
  });
  group('getNextDaysYear', () {
    test('last day of 2021 returns 2022 as String', () {
      CurrentWeatherController.to.currentTime = DateTime(2021, 12, 31);
      DateTimeFormatter.initNextDay(1);

      expect(DateTimeFormatter.getNextDaysYear(), '2022');
    });
    test('first day of 2021 returns 2021 as String', () {
      CurrentWeatherController.to.currentTime = DateTime(2021); // Jan 1 2021
      DateTimeFormatter.initNextDay(1);

      expect(DateTimeFormatter.getNextDaysYear(), '2021');
    });
  });
  group('formatTimeToHour', () {
    test('midnight DateTime returns 12 AM when timeIs24hrs is false', () {
      StorageController.to.storeTimeFormatSetting(timeIs24hrs: false);

      final midnight = DateTime(2021); // Jan 1 2021 12AM

      expect(DateTimeFormatter.formatTimeToHour(time: midnight), '12 AM');
    });
    test('11pm DateTime returns 11 PM when timeIs24hrs is false', () {
      StorageController.to.storeTimeFormatSetting(timeIs24hrs: false);

      final time = DateTime(2021, 1, 1, 23); // Jan 1 2021 11 PM

      expect(DateTimeFormatter.formatTimeToHour(time: time), '11 PM');
    });
    test('11pm or 23:00 DateTime returns 23:00 when timeIs24hrs is true', () {
      final time = DateTime(2021, 1, 1, 23); // Jan 1 2021 11 PM

      StorageController.to.storeTimeFormatSetting(timeIs24hrs: true);

      expect(DateTimeFormatter.formatTimeToHour(time: time), '23:00');
    });
    test('Noon DateTime returns 12:00 when timeIs24hrs is true', () {
      final time = DateTime(2021, 1, 1, 12); // Jan 1 2021 12 PM

      StorageController.to.storeTimeFormatSetting(timeIs24hrs: true);

      expect(DateTimeFormatter.formatTimeToHour(time: time), '12:00');
    });
  });
  group('formatFullTime', () {
    test('midnight DateTime returns 12:00 AM when timeIs24hrs is false', () {
      StorageController.to.storeTimeFormatSetting(timeIs24hrs: false);

      final midnight = DateTime(2021); // Jan 1 2021 12AM

      expect(DateTimeFormatter.formatFullTime(time: midnight), '12:00 AM');
    });
    test('11pm DateTime returns 11 PM when timeIs24hrs is false', () {
      StorageController.to.storeTimeFormatSetting(timeIs24hrs: false);

      final midnight = DateTime(2021, 1, 1, 23); // Jan 1 2021 11 PM

      expect(DateTimeFormatter.formatFullTime(time: midnight), '11:00 PM');
    });
    test('11pm or 23:00 DateTime returns 23:00 when timeIs24hrs is true', () {
      final midnight = DateTime(2021, 1, 1, 23); // Jan 1 2021 11 PM

      StorageController.to.storeTimeFormatSetting(timeIs24hrs: true);

      expect(DateTimeFormatter.formatFullTime(time: midnight), '23:00');
    });
    test('Noon DateTime returns 12:00 when timeIs24hrs is true', () {
      final midnight = DateTime(2021, 1, 1, 12); // Jan 1 2021 11 PM

      StorageController.to.storeTimeFormatSetting(timeIs24hrs: true);

      expect(DateTimeFormatter.formatFullTime(time: midnight), '12:00');
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
