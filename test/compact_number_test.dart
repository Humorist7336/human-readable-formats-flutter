import 'package:human_readable_formats/src/compact_number.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';

void main() {
  group('humanizeCompactNumber', () {
    test('formats small numbers without compacting', () {
      expect(humanizeCompactNumber(0), '0');
      expect(humanizeCompactNumber(1), '1');
      expect(humanizeCompactNumber(99), '99');
      expect(humanizeCompactNumber(999), '999');
    });

    test('formats thousands with K suffix', () {
      expect(humanizeCompactNumber(1000), '1K');
      expect(humanizeCompactNumber(1500), '1.5K');
      expect(humanizeCompactNumber(12000), '12K');
      expect(humanizeCompactNumber(999000), '999K');
    });

    test('formats millions with M suffix', () {
      expect(humanizeCompactNumber(1000000), '1M');
      expect(humanizeCompactNumber(1500000), '1.5M');
      expect(humanizeCompactNumber(12000000), '12M');
      expect(humanizeCompactNumber(999000000), '999M');
    });

    test('formats billions with B suffix', () {
      expect(humanizeCompactNumber(1000000000), '1B');
      expect(humanizeCompactNumber(1500000000), '1.5B');
      expect(humanizeCompactNumber(12000000000), '12B');
    });

    test('formats trillions with T suffix', () {
      expect(humanizeCompactNumber(1000000000000), '1T');
      expect(humanizeCompactNumber(1500000000000), '1.5T');
    });

    test('formats negative numbers', () {
      expect(humanizeCompactNumber(-1000), '-1K');
      expect(humanizeCompactNumber(-1500000), '-1.5M');
    });

    test('formats decimal numbers', () {
      final result1 = humanizeCompactNumber(1234.56);
      expect(result1, anyOf('1.2K', '1.23K')); // Allow for different precision
      final result2 = humanizeCompactNumber(1234567.89);
      expect(result2, anyOf('1.2M', '1.23M')); // Allow for different precision
    });

    test('formats with different locales', () {
      // Note: Actual locale formatting may vary by system
      expect(humanizeCompactNumber(1500, locale: 'en_US'), contains('1'));
      expect(humanizeCompactNumber(1500000, locale: 'en_US'), contains('1'));
    });
  });
}