import 'package:human_readable_formats/src/relative_time.dart';
import 'package:test/test.dart';

void main() {
  group('humanizeRelativeTime', () {
    final now = DateTime(2024, 1, 15, 12, 0, 0); // Fixed reference time

    test('formats just now for recent times', () {
      final recent = now.subtract(const Duration(seconds: 30));
      expect(humanizeRelativeTime(recent, now: now), 'just now');
      
      final veryRecent = now.subtract(const Duration(seconds: 5));
      expect(humanizeRelativeTime(veryRecent, now: now), 'just now');
    });

    test('formats minutes ago', () {
      final oneMinuteAgo = now.subtract(const Duration(minutes: 1));
      expect(humanizeRelativeTime(oneMinuteAgo, now: now), '1 minute ago');
      
      final fiveMinutesAgo = now.subtract(const Duration(minutes: 5));
      expect(humanizeRelativeTime(fiveMinutesAgo, now: now), '5 minutes ago');
      
      final fiftyNineMinutesAgo = now.subtract(const Duration(minutes: 59));
      expect(humanizeRelativeTime(fiftyNineMinutesAgo, now: now), '59 minutes ago');
    });

    test('formats hours ago', () {
      final oneHourAgo = now.subtract(const Duration(hours: 1));
      expect(humanizeRelativeTime(oneHourAgo, now: now), '1 hour ago');
      
      final fiveHoursAgo = now.subtract(const Duration(hours: 5));
      expect(humanizeRelativeTime(fiveHoursAgo, now: now), '5 hours ago');
      
      final twentyThreeHoursAgo = now.subtract(const Duration(hours: 23));
      expect(humanizeRelativeTime(twentyThreeHoursAgo, now: now), '23 hours ago');
    });

    test('formats days ago', () {
      final oneDayAgo = now.subtract(const Duration(days: 1));
      expect(humanizeRelativeTime(oneDayAgo, now: now), '1 day ago');
      
      final threeDaysAgo = now.subtract(const Duration(days: 3));
      expect(humanizeRelativeTime(threeDaysAgo, now: now), '3 days ago');
      
      final sixDaysAgo = now.subtract(const Duration(days: 6));
      expect(humanizeRelativeTime(sixDaysAgo, now: now), '6 days ago');
    });

    test('formats weeks ago', () {
      final oneWeekAgo = now.subtract(const Duration(days: 7));
      expect(humanizeRelativeTime(oneWeekAgo, now: now), '1 week ago');
      
      final twoWeeksAgo = now.subtract(const Duration(days: 14));
      expect(humanizeRelativeTime(twoWeeksAgo, now: now), '2 weeks ago');
      
      final threeWeeksAgo = now.subtract(const Duration(days: 21));
      expect(humanizeRelativeTime(threeWeeksAgo, now: now), '3 weeks ago');
    });

    test('formats months ago', () {
      final oneMonthAgo = now.subtract(const Duration(days: 30));
      expect(humanizeRelativeTime(oneMonthAgo, now: now), '1 month ago');
      
      final twoMonthsAgo = now.subtract(const Duration(days: 60));
      expect(humanizeRelativeTime(twoMonthsAgo, now: now), '2 months ago');
      
      final elevenMonthsAgo = now.subtract(const Duration(days: 330));
      expect(humanizeRelativeTime(elevenMonthsAgo, now: now), '11 months ago');
    });

    test('formats years ago', () {
      final oneYearAgo = now.subtract(const Duration(days: 365));
      expect(humanizeRelativeTime(oneYearAgo, now: now), '1 year ago');
      
      final twoYearsAgo = now.subtract(const Duration(days: 730));
      expect(humanizeRelativeTime(twoYearsAgo, now: now), '2 years ago');
    });

    test('uses current time when now is not provided', () {
      final recent = DateTime.now().subtract(const Duration(seconds: 30));
      expect(humanizeRelativeTime(recent), 'just now');
    });

    test('handles edge cases', () {
      // Exactly 1 minute
      final exactlyOneMinute = now.subtract(const Duration(minutes: 1));
      expect(humanizeRelativeTime(exactlyOneMinute, now: now), '1 minute ago');
      
      // Exactly 1 hour
      final exactlyOneHour = now.subtract(const Duration(hours: 1));
      expect(humanizeRelativeTime(exactlyOneHour, now: now), '1 hour ago');
      
      // Exactly 1 day
      final exactlyOneDay = now.subtract(const Duration(days: 1));
      expect(humanizeRelativeTime(exactlyOneDay, now: now), '1 day ago');
    });
  });
}