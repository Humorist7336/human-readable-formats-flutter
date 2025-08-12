import 'package:test/test.dart';
import 'package:human_readable_formats/src/time.dart';

void main() {
  group('humanizePreciseDuration', () {
    test('formats duration with multiple units', () {
      expect(humanizePreciseDuration(Duration(days: 365, hours: 5)), '1y 5h');
      expect(humanizePreciseDuration(Duration(days: 32, hours: 3)), '1mo 2d');
      expect(humanizePreciseDuration(Duration(hours: 25, minutes: 30)), '1d 1h');
    });

    test('handles maxUnits parameter', () {
      final duration = Duration(days: 365, hours: 5, minutes: 30, seconds: 45);
      expect(humanizePreciseDuration(duration, maxUnits: 1), '1y');
      expect(humanizePreciseDuration(duration, maxUnits: 3), '1y 5h 30m');
    });

    test('handles small durations', () {
      expect(humanizePreciseDuration(Duration(seconds: 30)), '30s');
      expect(humanizePreciseDuration(Duration(milliseconds: 500)), '500ms');
      expect(humanizePreciseDuration(Duration.zero), '0s');
    });

    test('handles negative durations', () {
      expect(humanizePreciseDuration(Duration(hours: -2)), '-2h');
      expect(humanizePreciseDuration(Duration(minutes: -30)), '-30m');
    });
  });

  group('humanizeTime12Hour', () {
    test('formats time in 12-hour format', () {
      expect(humanizeTime12Hour(DateTime(2023, 1, 1, 9, 30)), '09:30 AM');
      expect(humanizeTime12Hour(DateTime(2023, 1, 1, 15, 45)), '03:45 PM');
      expect(humanizeTime12Hour(DateTime(2023, 1, 1, 0, 0)), '12:00 AM');
      expect(humanizeTime12Hour(DateTime(2023, 1, 1, 12, 0)), '12:00 PM');
    });
  });

  group('humanizeTime24Hour', () {
    test('formats time in 24-hour format', () {
      expect(humanizeTime24Hour(DateTime(2023, 1, 1, 9, 30)), '09:30');
      expect(humanizeTime24Hour(DateTime(2023, 1, 1, 15, 45)), '15:45');
      expect(humanizeTime24Hour(DateTime(2023, 1, 1, 0, 0)), '00:00');
    });
  });

  group('humanizeTimeAgo', () {
    final now = DateTime(2023, 6, 15, 12, 0, 0);

    test('formats recent times', () {
      expect(humanizeTimeAgo(now.subtract(Duration(seconds: 30)), now: now), 'just now');
      expect(humanizeTimeAgo(now.subtract(Duration(minutes: 5)), now: now), '5 minutes ago');
      expect(humanizeTimeAgo(now.subtract(Duration(minutes: 1)), now: now), '1 minute ago');
    });

    test('formats hours and days', () {
      expect(humanizeTimeAgo(now.subtract(Duration(hours: 2)), now: now), '2 hours ago');
      expect(humanizeTimeAgo(now.subtract(Duration(hours: 1)), now: now), '1 hour ago');
      expect(humanizeTimeAgo(now.subtract(Duration(days: 3)), now: now), '3 days ago');
      expect(humanizeTimeAgo(now.subtract(Duration(days: 1)), now: now), '1 day ago');
    });

    test('formats weeks, months, and years', () {
      expect(humanizeTimeAgo(now.subtract(Duration(days: 14)), now: now), '2 weeks ago');
      expect(humanizeTimeAgo(now.subtract(Duration(days: 60)), now: now), '2 months ago');
      expect(humanizeTimeAgo(now.subtract(Duration(days: 400)), now: now), '1 year ago');
    });
  });

  group('humanizeTimeUntil', () {
    final now = DateTime(2023, 6, 15, 12, 0, 0);

    test('formats future times', () {
      expect(humanizeTimeUntil(now.add(Duration(seconds: 30)), now: now), 'in a few seconds');
      expect(humanizeTimeUntil(now.add(Duration(minutes: 5)), now: now), 'in 5 minutes');
      expect(humanizeTimeUntil(now.add(Duration(hours: 2)), now: now), 'in 2 hours');
      expect(humanizeTimeUntil(now.add(Duration(days: 3)), now: now), 'in 3 days');
    });
  });

  group('humanizeDateRange', () {
    test('formats same day', () {
      final date = DateTime(2023, 6, 15);
      expect(humanizeDateRange(date, date), 'on Jun 15, 2023');
    });

    test('formats consecutive days', () {
      final start = DateTime(2023, 6, 15);
      final end = DateTime(2023, 6, 16);
      expect(humanizeDateRange(start, end), 'from Jun 15, 2023 to Jun 16, 2023');
    });

    test('formats longer ranges', () {
      final start = DateTime(2023, 6, 15);
      final end = DateTime(2023, 6, 20);
      expect(humanizeDateRange(start, end), 'from Jun 15, 2023 to Jun 20, 2023 (6 days)');
    });
  });

  group('humanizeTimezone', () {
    test('formats positive offsets', () {
      expect(humanizeTimezone(Duration(hours: 5, minutes: 30)), 'UTC+05:30');
      expect(humanizeTimezone(Duration(hours: 8)), 'UTC+08:00');
    });

    test('formats negative offsets', () {
      expect(humanizeTimezone(Duration(hours: -5)), 'UTC-05:00');
      expect(humanizeTimezone(Duration(hours: -8, minutes: -30)), 'UTC-08:30');
    });

    test('formats zero offset', () {
      expect(humanizeTimezone(Duration.zero), 'UTC+00:00');
    });
  });

  group('humanizeUptime', () {
    test('formats uptime with various units', () {
      expect(humanizeUptime(Duration(seconds: 30)), '30s');
      expect(humanizeUptime(Duration(minutes: 5, seconds: 30)), '5m 30s');
      expect(humanizeUptime(Duration(hours: 2, minutes: 30)), '2h 30m');
      expect(humanizeUptime(Duration(days: 1, hours: 5, minutes: 30)), '1d 5h 30m');
    });

    test('handles zero uptime', () {
      expect(humanizeUptime(Duration.zero), '0s');
    });
  });

  group('humanizeAge', () {
    final now = DateTime(2023, 6, 15);

    test('formats age in years', () {
      final birthDate = DateTime(2020, 6, 15);
      expect(humanizeAge(birthDate, now: now), '3y');
    });

    test('formats age with months', () {
      final birthDate = DateTime(2020, 3, 15);
      expect(humanizeAge(birthDate, now: now), '3y 3mo');
    });

    test('formats age in months for babies', () {
      final birthDate = DateTime(2023, 3, 15);
      expect(humanizeAge(birthDate, now: now), '3mo');
    });

    test('formats age in days for newborns', () {
      final birthDate = DateTime(2023, 6, 1);
      expect(humanizeAge(birthDate, now: now), '14d');
    });
  });

  group('humanizeCountdown', () {
    test('formats countdown with hours', () {
      expect(humanizeCountdown(Duration(hours: 2, minutes: 30, seconds: 45)), '02:30:45');
      expect(humanizeCountdown(Duration(hours: 1, minutes: 5, seconds: 30)), '01:05:30');
    });

    test('formats countdown without hours', () {
      expect(humanizeCountdown(Duration(minutes: 30, seconds: 45)), '30:45');
      expect(humanizeCountdown(Duration(minutes: 5, seconds: 30)), '05:30');
    });

    test('handles zero and negative durations', () {
      expect(humanizeCountdown(Duration.zero), '00:00');
      expect(humanizeCountdown(Duration(minutes: -5)), '00:00:00');
    });
  });

  group('humanizeStopwatch', () {
    test('formats stopwatch time', () {
      expect(humanizeStopwatch(Duration(minutes: 5, seconds: 30, milliseconds: 250)), '05:30.250');
      expect(humanizeStopwatch(Duration(seconds: 45, milliseconds: 123)), '00:45.123');
      expect(humanizeStopwatch(Duration(milliseconds: 500)), '00:00.500');
    });

    test('handles longer durations', () {
      expect(humanizeStopwatch(Duration(minutes: 65, seconds: 30)), '65:30.000');
    });
  });
}