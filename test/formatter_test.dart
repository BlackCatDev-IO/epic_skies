import 'package:epic_skies/services/utils/conversions/date_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final formatter = DateTimeFormatter();

  group('getNext7Days', () {
    test('1', () {
      expect(formatter.getNext7Days(1), 'Mon');
    });
    test('2', () {
      expect(formatter.getNext7Days(2), 'Tue');
    });
    test('3', () {
      expect(formatter.getNext7Days(3), 'Wed');
    });
    test('4', () {
      expect(formatter.getNext7Days(4), 'Thu');
    });
    test('5', () {
      expect(formatter.getNext7Days(5), 'Fri');
    });
    test('6', () {
      expect(formatter.getNext7Days(6), 'Sat');
    });
    test('7', () {
      expect(formatter.getNext7Days(7), 'Sun');
    });
  });
}
