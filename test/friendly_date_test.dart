import 'package:human_readable_formats/human_readable_formats.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

void main() {
  // Initialize date formatting for consistent test results
  setUpAll(() async {
    // Force US locale for consistent test results
    await initializeDateFormatting('en_US', null);
    Intl.defaultLocale = 'en_US';
  });

  group('humanizeFriendlyDate', () {
    final now = DateTime(2025, 7, 21, 15, 45); // Monday at 3:45 PM

    group('without time', () {
      test('formats today', () {
        expect(humanizeFriendlyDate(now, now: now), 'Today');
      });

      test('formats yesterday', () {
        final yesterday = now.subtract(const Duration(days: 1));
        expect(humanizeFriendlyDate(yesterday, now: now), 'Yesterday');
      });

      test('formats tomorrow', () {
        final tomorrow = now.add(const Duration(days: 1));
        expect(humanizeFriendlyDate(tomorrow, now: now), 'Tomorrow');
      });

      test('formats last week days', () {
        final lastFriday = now.subtract(const Duration(days: 3));
        expect(humanizeFriendlyDate(lastFriday, now: now), 'Last Friday');
      });

      test('formats next week days', () {
        final nextWednesday = now.add(const Duration(days: 2));
        expect(humanizeFriendlyDate(nextWednesday, now: now), 'Next Wednesday');
      });

      test('formats distant dates', () {
        final distantPast = DateTime(2024, 1, 15);
        final result = humanizeFriendlyDate(distantPast, now: now);
        expect(result, contains('Jan'));
        expect(result, contains('15'));
        expect(result, contains('2024'));
      });
    });

    group('with time', () {
      const includeTime = true;

      test('formats today with time', () {
        final result = humanizeFriendlyDate(now, now: now, includeTime: includeTime);
        expect(result, startsWith('Today at'));
        expect(result, contains('3:45'));
        expect(result, contains('PM'));
      });

      test('formats yesterday with time', () {
        final yesterday = now.subtract(const Duration(days: 1));
        final result = humanizeFriendlyDate(yesterday, now: now, includeTime: includeTime);
        expect(result, startsWith('Yesterday at'));
        expect(result, contains('3:45'));
        expect(result, contains('PM'));
      });

      test('formats last week days with time', () {
        final lastFriday = now.subtract(const Duration(days: 3));
        final result = humanizeFriendlyDate(lastFriday, now: now, includeTime: includeTime);
        expect(result, startsWith('Last Friday at'));
        expect(result, contains('3:45'));
        expect(result, contains('PM'));
      });

      test('formats distant dates with time', () {
        final distantPast = DateTime(2024, 1, 15, 10, 30);
        final result = humanizeFriendlyDate(distantPast, now: now, includeTime: includeTime);
        expect(result, contains('Jan 15, 2024 at'));
        expect(result, contains('10:30'));
        expect(result, contains('AM'));
      });
    });

    group('Localization', () {
      test('uses English by default', () {
        expect(humanizeFriendlyDate(now, now: now), 'Today');
        final yesterday = now.subtract(const Duration(days: 1));
        expect(humanizeFriendlyDate(yesterday, now: now), 'Yesterday');
        final tomorrow = now.add(const Duration(days: 1));
        expect(humanizeFriendlyDate(tomorrow, now: now), 'Tomorrow');
      });

      test('uses Spanish when locale is provided', () {
        expect(humanizeFriendlyDate(now, now: now, locale: 'es'), 'Hoy');
        final yesterday = now.subtract(const Duration(days: 1));
        expect(humanizeFriendlyDate(yesterday, now: now, locale: 'es'), 'Ayer');
        final tomorrow = now.add(const Duration(days: 1));
        expect(humanizeFriendlyDate(tomorrow, now: now, locale: 'es'), 'Mañana');
      });

      test('uses Spanish with time conjunction', () {
        final result = humanizeFriendlyDate(now, now: now, includeTime: true, locale: 'es');
        expect(result, startsWith('Hoy a las'));
        expect(result, contains('3:45'));
        expect(result, contains('PM'));
      });

      test('uses Spanish with relative days', () {
        final lastFriday = now.subtract(const Duration(days: 3));
        final result = humanizeFriendlyDate(lastFriday, now: now, locale: 'es');
        expect(result, startsWith('El'));
        expect(result, contains('Friday')); // Note: weekday names would need separate localization
        
        final nextWednesday = now.add(const Duration(days: 2));
        final nextResult = humanizeFriendlyDate(nextWednesday, now: now, locale: 'es');
        expect(nextResult, startsWith('El próximo'));
        expect(nextResult, contains('Wednesday'));
      });
    });
  });
}

