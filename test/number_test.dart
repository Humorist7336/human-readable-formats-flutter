import 'package:test/test.dart';
import 'package:human_readable_formats/src/number.dart';

void main() {
  group('humanizeNumber', () {
    test('formats numbers with thousands separators', () {
      expect(humanizeNumber(1234), '1,234');
      expect(humanizeNumber(1234567), '1,234,567');
      expect(humanizeNumber(1234567.89), '1,234,567.89');
    });

    test('handles custom separators', () {
      expect(humanizeNumber(1234567, separator: ' '), '1 234 567');
      expect(humanizeNumber(1234567, separator: '.'), '1.234.567');
    });

    test('handles small numbers', () {
      expect(humanizeNumber(123), '123');
      expect(humanizeNumber(12.34), '12.34');
    });
  });

  group('humanizeScientific', () {
    test('formats numbers in scientific notation', () {
      expect(humanizeScientific(1234567), '1.23e+6');
      expect(humanizeScientific(0.000123), '1.23e-4');
    });

    test('handles custom precision', () {
      expect(humanizeScientific(1234567, precision: 3), '1.235e+6');
      expect(humanizeScientific(1234567, precision: 1), '1.2e+6');
    });
  });

  group('humanizeBinary', () {
    test('converts numbers to binary', () {
      expect(humanizeBinary(10), '1010');
      expect(humanizeBinary(255), '11111111');
      expect(humanizeBinary(0), '0');
    });
  });

  group('humanizeHex', () {
    test('converts numbers to hexadecimal', () {
      expect(humanizeHex(255), 'FF');
      expect(humanizeHex(16), '10');
      expect(humanizeHex(0), '0');
    });

    test('handles lowercase option', () {
      expect(humanizeHex(255, uppercase: false), 'ff');
      expect(humanizeHex(255, uppercase: true), 'FF');
    });
  });

  group('humanizeOctal', () {
    test('converts numbers to octal', () {
      expect(humanizeOctal(64), '100');
      expect(humanizeOctal(8), '10');
      expect(humanizeOctal(0), '0');
    });
  });

  group('humanizeDecimal', () {
    test('formats numbers with fixed decimal places', () {
      expect(humanizeDecimal(3.14159), '3.14');
      expect(humanizeDecimal(3.14159, decimalPlaces: 3), '3.142');
      expect(humanizeDecimal(3, decimalPlaces: 2), '3.00');
    });
  });

  group('humanizeRoman', () {
    test('converts numbers to Roman numerals', () {
      expect(humanizeRoman(1), 'I');
      expect(humanizeRoman(4), 'IV');
      expect(humanizeRoman(9), 'IX');
      expect(humanizeRoman(27), 'XXVII');
      expect(humanizeRoman(48), 'XLVIII');
      expect(humanizeRoman(1994), 'MCMXCIV');
    });

    test('throws error for invalid ranges', () {
      expect(() => humanizeRoman(0), throwsArgumentError);
      expect(() => humanizeRoman(4000), throwsArgumentError);
      expect(() => humanizeRoman(-1), throwsArgumentError);
    });
  });

  group('humanizeMagnitude', () {
    test('formats numbers with magnitude suffixes', () {
      expect(humanizeMagnitude(1234), '1.2K');
      expect(humanizeMagnitude(1234567), '1.2M');
      expect(humanizeMagnitude(1234567890), '1.2B');
    });

    test('handles small numbers', () {
      expect(humanizeMagnitude(123), '123');
      expect(humanizeMagnitude(999), '999');
    });

    test('handles custom precision', () {
      expect(humanizeMagnitude(1234567, precision: 2), '1.23M');
      expect(humanizeMagnitude(1234567, precision: 0), '1M');
    });
  });

  group('humanizeFraction', () {
    test('converts decimals to fractions', () {
      expect(humanizeFraction(0.5), '1/2');
      expect(humanizeFraction(0.25), '1/4');
      expect(humanizeFraction(0.75), '3/4');
      expect(humanizeFraction(0.333), '1/3');
    });

    test('handles whole numbers', () {
      expect(humanizeFraction(3.0), '3');
      expect(humanizeFraction(5.0), '5');
    });

    test('handles custom max denominator', () {
      expect(humanizeFraction(0.333, maxDenominator: 10), '1/3');
      expect(humanizeFraction(0.142857, maxDenominator: 10), '1/7');
    });
  });

  group('humanizeMetric', () {
    test('formats numbers with metric prefixes', () {
      expect(humanizeMetric(1000), '1.00k');
      expect(humanizeMetric(1000000), '1.00M');
      expect(humanizeMetric(0.001), '1.00m');
      expect(humanizeMetric(0.000001), '1.00μ');
    });

    test('handles units', () {
      expect(humanizeMetric(1000, unit: 'g'), '1.00kg');
      expect(humanizeMetric(0.001, unit: 'A'), '1.00mA');
    });

    test('handles custom precision', () {
      expect(humanizeMetric(1234, precision: 1), '1.2k');
      expect(humanizeMetric(1234, precision: 3), '1.234k');
    });
  });
}