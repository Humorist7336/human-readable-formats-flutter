import 'package:human_readable_formats/src/currency.dart';
import 'package:test/test.dart';

void main() {
  group('humanizeCurrency', () {
    test('formats currency with default rupee symbol', () {
      expect(humanizeCurrency(99), '₹99');
      expect(humanizeCurrency(1000), '₹1,000');
    });

    test('formats currency with custom symbol', () {
      expect(humanizeCurrency(99, symbol: '\$'), '\$99');
      expect(humanizeCurrency(1000, symbol: '€'), '€1,000');
    });

    test('formats currency with locale', () {
      expect(humanizeCurrency(1234.56, symbol: '\$', locale: 'en_US'), '\$1,235');
      final result = humanizeCurrency(1234.56, symbol: '€', locale: 'de_DE');
      expect(result, contains('€')); // Check that Euro symbol is present
      expect(result, contains('1')); // Check that the number is present
    });

    test('formats zero amount', () {
      expect(humanizeCurrency(0), '₹0');
      expect(humanizeCurrency(0, symbol: '\$'), '\$0');
    });

    test('formats negative amounts', () {
      expect(humanizeCurrency(-100), '-₹100');
      expect(humanizeCurrency(-1000, symbol: '\$'), '-\$1,000');
    });

    test('formats large amounts', () {
      expect(humanizeCurrency(1000000), '₹1,000,000');
      expect(humanizeCurrency(1000000, symbol: '\$'), '\$1,000,000');
    });

    test('formats decimal amounts (rounds to nearest)', () {
      expect(humanizeCurrency(99.4), '₹99');
      expect(humanizeCurrency(99.6), '₹100');
    });
  });
}