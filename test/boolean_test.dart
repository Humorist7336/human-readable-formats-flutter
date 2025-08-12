import 'package:human_readable_formats/src/boolean.dart';
import 'package:test/test.dart';

void main() {
  group('humanizeBoolean', () {
    test('formats true value with default labels', () {
      expect(humanizeBoolean(true), 'Yes');
    });

    test('formats false value with default labels', () {
      expect(humanizeBoolean(false), 'No');
    });

    test('formats null value with default label', () {
      expect(humanizeBoolean(null), 'Unknown');
    });

    test('formats true value with custom labels', () {
      expect(humanizeBoolean(true, positive: 'Active', negative: 'Inactive'), 'Active');
    });

    test('formats false value with custom labels', () {
      expect(humanizeBoolean(false, positive: 'Active', negative: 'Inactive'), 'Inactive');
    });

    test('formats null value with custom null label', () {
      expect(humanizeBoolean(null, nullValue: 'Not Set'), 'Not Set');
    });

    test('formats with enabled/disabled labels', () {
      expect(humanizeBoolean(true, positive: 'Enabled', negative: 'Disabled'), 'Enabled');
      expect(humanizeBoolean(false, positive: 'Enabled', negative: 'Disabled'), 'Disabled');
    });

    test('formats with on/off labels', () {
      expect(humanizeBoolean(true, positive: 'On', negative: 'Off'), 'On');
      expect(humanizeBoolean(false, positive: 'On', negative: 'Off'), 'Off');
    });
  });
}