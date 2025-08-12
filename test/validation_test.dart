import 'package:test/test.dart';
import 'package:human_readable_formats/src/validation.dart';

void main() {
  group('File Size Validation', () {
    test('validates valid file sizes', () {
      expect(isValidFileSize('1.5 GB'), isTrue);
      expect(isValidFileSize('500 MB'), isTrue);
      expect(isValidFileSize('1024 KiB'), isTrue);
      expect(isValidFileSize('2.5TB'), isTrue);
    });

    test('rejects invalid file sizes', () {
      expect(isValidFileSize('1.5 XB'), isFalse);
      expect(isValidFileSize('invalid'), isFalse);
      expect(isValidFileSize(''), isFalse);
    });
  });

  group('Duration Validation', () {
    test('validates valid durations', () {
      expect(isValidDuration('1h30m'), isTrue);
      expect(isValidDuration('2d 5h'), isTrue);
      expect(isValidDuration('1y 6mo 2w 3d 4h 30m 45s'), isTrue);
      expect(isValidDuration('30s'), isTrue);
    });

    test('rejects invalid durations', () {
      expect(isValidDuration('invalid'), isFalse);
      expect(isValidDuration(''), isFalse);
      expect(isValidDuration('1x'), isFalse);
    });
  });

  group('Percentage Validation', () {
    test('validates valid percentages', () {
      expect(isValidPercentage('50%'), isTrue);
      expect(isValidPercentage('99.9%'), isTrue);
      expect(isValidPercentage('0%'), isTrue);
      expect(isValidPercentage('100%'), isTrue);
    });

    test('rejects invalid percentages', () {
      expect(isValidPercentage('50'), isFalse);
      expect(isValidPercentage('%50'), isFalse);
      expect(isValidPercentage('invalid%'), isFalse);
    });
  });

  group('Currency Validation', () {
    test('validates valid currencies', () {
      expect(isValidCurrency('\$1,234.56'), isTrue);
      expect(isValidCurrency('€999'), isTrue);
      expect(isValidCurrency('₹1,00,000.00'), isFalse); // Indian format not supported
    });

    test('rejects invalid currencies', () {
      expect(isValidCurrency('1234'), isFalse);
      expect(isValidCurrency('invalid'), isFalse);
    });
  });

  group('Number Format Validation', () {
    test('validates hex numbers', () {
      expect(isValidHex('FF'), isTrue);
      expect(isValidHex('1A2B3C'), isTrue);
      expect(isValidHex('123'), isTrue);
    });

    test('validates binary numbers', () {
      expect(isValidBinary('1010'), isTrue);
      expect(isValidBinary('11111111'), isTrue);
      expect(isValidBinary('0'), isTrue);
    });

    test('validates octal numbers', () {
      expect(isValidOctal('777'), isTrue);
      expect(isValidOctal('123'), isTrue);
      expect(isValidOctal('0'), isTrue);
    });

    test('validates Roman numerals', () {
      expect(isValidRoman('IV'), isTrue);
      expect(isValidRoman('MCMXC'), isTrue);
      expect(isValidRoman('XLII'), isTrue);
    });

    test('validates scientific notation', () {
      expect(isValidScientific('1.23e+6'), isTrue);
      expect(isValidScientific('5E-3'), isTrue);
      expect(isValidScientific('2.5e10'), isTrue);
    });

    test('validates fractions', () {
      expect(isValidFraction('1/2'), isTrue);
      expect(isValidFraction('3/4'), isTrue);
      expect(isValidFraction('22/7'), isTrue);
    });
  });

  group('Time Format Validation', () {
    test('validates 12-hour time format', () {
      expect(isValidTime12Hour('9:30 AM'), isTrue);
      expect(isValidTime12Hour('11:45 PM'), isTrue);
      expect(isValidTime12Hour('12:00 AM'), isTrue);
    });

    test('validates 24-hour time format', () {
      expect(isValidTime24Hour('09:30'), isTrue);
      expect(isValidTime24Hour('23:45'), isTrue);
      expect(isValidTime24Hour('00:00'), isTrue);
    });

    test('validates timezone format', () {
      expect(isValidTimezone('UTC+05:30'), isTrue);
      expect(isValidTimezone('UTC-08:00'), isTrue);
      expect(isValidTimezone('UTC+00:00'), isTrue);
    });
  });

  group('Network Validation', () {
    test('validates IPv4 addresses', () {
      expect(isValidIPv4('192.168.1.1'), isTrue);
      expect(isValidIPv4('10.0.0.1'), isTrue);
      expect(isValidIPv4('255.255.255.255'), isTrue);
    });

    test('rejects invalid IPv4 addresses', () {
      expect(isValidIPv4('256.1.1.1'), isFalse);
      expect(isValidIPv4('192.168.1'), isFalse);
      expect(isValidIPv4('invalid'), isFalse);
    });

    test('validates IPv6 addresses', () {
      expect(isValidIPv6('2001:0db8:85a3:0000:0000:8a2e:0370:7334'), isTrue);
      expect(isValidIPv6('fe80:0000:0000:0000:0202:b3ff:fe1e:8329'), isTrue);
    });

    test('validates MAC addresses', () {
      expect(isValidMACAddress('00:1B:44:11:3A:B7'), isTrue);
      expect(isValidMACAddress('00-1B-44-11-3A-B7'), isTrue);
    });

    test('validates URLs', () {
      expect(isValidURL('https://example.com'), isTrue);
      expect(isValidURL('http://localhost:3000'), isTrue);
      expect(isValidURL('ftp://files.example.com'), isTrue);
    });

    test('rejects invalid URLs', () {
      expect(isValidURL('not-a-url'), isFalse);
      expect(isValidURL('example.com'), isFalse);
    });
  });

  group('Contact Information Validation', () {
    test('validates email addresses', () {
      expect(isValidEmail('user@example.com'), isTrue);
      expect(isValidEmail('test.email+tag@domain.co.uk'), isTrue);
    });

    test('rejects invalid email addresses', () {
      expect(isValidEmail('invalid-email'), isFalse);
      expect(isValidEmail('@example.com'), isFalse);
      expect(isValidEmail('user@'), isFalse);
    });

    test('validates phone numbers', () {
      expect(isValidPhoneNumber('+1 (555) 123-4567'), isTrue);
      expect(isValidPhoneNumber('555-123-4567'), isTrue);
      expect(isValidPhoneNumber('+44 20 7946 0958'), isTrue);
    });
  });

  group('Financial Validation', () {
    test('validates credit card numbers', () {
      expect(isValidCreditCard('4532015112830366'), isTrue); // Valid Visa test number
      expect(isValidCreditCard('4532 0151 1283 0366'), isTrue); // With spaces
    });

    test('rejects invalid credit card numbers', () {
      expect(isValidCreditCard('1234567890123456'), isFalse);
      expect(isValidCreditCard('invalid'), isFalse);
    });
  });

  group('Postal Code Validation', () {
    test('validates US ZIP codes', () {
      expect(isValidUSZipCode('12345'), isTrue);
      expect(isValidUSZipCode('12345-6789'), isTrue);
    });

    test('validates UK postal codes', () {
      expect(isValidUKPostalCode('SW1A 1AA'), isTrue);
      expect(isValidUKPostalCode('M1 1AA'), isTrue);
    });

    test('validates Canadian postal codes', () {
      expect(isValidCanadianPostalCode('K1A 0A6'), isTrue);
      expect(isValidCanadianPostalCode('M5V 3L9'), isTrue);
    });
  });

  group('Color Validation', () {
    test('validates hex colors', () {
      expect(isValidColorHex('#FF0000'), isTrue);
      expect(isValidColorHex('#f00'), isTrue);
      expect(isValidColorHex('FF0000'), isTrue);
    });

    test('validates RGB colors', () {
      expect(isValidColorRGB('rgb(255, 0, 0)'), isTrue);
      expect(isValidColorRGB('rgb(0,255,0)'), isTrue);
    });

    test('validates RGBA colors', () {
      expect(isValidColorRGBA('rgba(255, 0, 0, 0.5)'), isTrue);
      expect(isValidColorRGBA('rgba(0,255,0,1)'), isTrue);
    });

    test('validates HSL colors', () {
      expect(isValidColorHSL('hsl(0, 100%, 50%)'), isTrue);
      expect(isValidColorHSL('hsl(120,100%,50%)'), isTrue);
    });
  });

  group('Range Validation', () {
    test('validates number ranges', () {
      expect(isNumberInRange(5, 1, 10), isTrue);
      expect(isNumberInRange(0, 1, 10), isFalse);
      expect(isNumberInRange(15, 1, 10), isFalse);
    });

    test('validates string length ranges', () {
      expect(isStringLengthInRange('hello', 3, 10), isTrue);
      expect(isStringLengthInRange('hi', 3, 10), isFalse);
      expect(isStringLengthInRange('this is too long', 3, 10), isFalse);
    });

    test('validates date ranges', () {
      final start = DateTime(2023, 1, 1);
      final end = DateTime(2023, 12, 31);
      final testDate = DateTime(2023, 6, 15);
      
      expect(isDateInRange(testDate, start, end), isTrue);
      expect(isDateInRange(DateTime(2022, 6, 15), start, end), isFalse);
      expect(isDateInRange(DateTime(2024, 6, 15), start, end), isFalse);
    });
  });
}