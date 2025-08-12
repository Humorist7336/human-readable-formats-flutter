/// Formats a duration in a more precise way with multiple units.
String humanizePreciseDuration(Duration duration, {int maxUnits = 2}) {
  if (duration.isNegative) {
    return '-${humanizePreciseDuration(-duration, maxUnits: maxUnits)}';
  }

  final units = <String>[];
  var remaining = duration;

  // Years (approximate)
  final years = remaining.inDays ~/ 365;
  if (years > 0) {
    units.add('${years}y');
    remaining = Duration(days: remaining.inDays % 365, hours: remaining.inHours % 24, minutes: remaining.inMinutes % 60, seconds: remaining.inSeconds % 60);
  }

  // Months (approximate)
  final months = remaining.inDays ~/ 30;
  if (months > 0 && units.length < maxUnits) {
    units.add('${months}mo');
    remaining = Duration(days: remaining.inDays % 30, hours: remaining.inHours % 24, minutes: remaining.inMinutes % 60, seconds: remaining.inSeconds % 60);
  }

  // Days
  if (remaining.inDays > 0 && units.length < maxUnits) {
    units.add('${remaining.inDays}d');
  }

  // Hours
  final hours = remaining.inHours % 24;
  if (hours > 0 && units.length < maxUnits) {
    units.add('${hours}h');
  }

  // Minutes
  final minutes = remaining.inMinutes % 60;
  if (minutes > 0 && units.length < maxUnits) {
    units.add('${minutes}m');
  }

  // Seconds
  final seconds = remaining.inSeconds % 60;
  if (seconds > 0 && units.length < maxUnits) {
    units.add('${seconds}s');
  }

  // Milliseconds (if no larger units)
  if (units.isEmpty) {
    final milliseconds = remaining.inMilliseconds;
    if (milliseconds > 0) {
      units.add('${milliseconds}ms');
    } else {
      return '0s';
    }
  }

  return units.take(maxUnits).join(' ');
}

/// Formats time in 12-hour format with AM/PM.
String humanizeTime12Hour(DateTime dateTime) {
  final hour = dateTime.hour;
  final minute = dateTime.minute;
  final period = hour >= 12 ? 'PM' : 'AM';
  final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  
  return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
}

/// Formats time in 24-hour format.
String humanizeTime24Hour(DateTime dateTime) {
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

/// Formats a timestamp as time ago with more precision.
String humanizeTimeAgo(DateTime dateTime, {DateTime? now}) {
  now ??= DateTime.now();
  final difference = now.difference(dateTime);
  
  if (difference.isNegative) {
    return humanizeTimeUntil(dateTime, now: now);
  }
  
  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return '${minutes} minute${minutes == 1 ? '' : 's'} ago';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return '${hours} hour${hours == 1 ? '' : 's'} ago';
  } else if (difference.inDays < 7) {
    final days = difference.inDays;
    return '${days} day${days == 1 ? '' : 's'} ago';
  } else if (difference.inDays < 30) {
    final weeks = difference.inDays ~/ 7;
    return '${weeks} week${weeks == 1 ? '' : 's'} ago';
  } else if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    return '${months} month${months == 1 ? '' : 's'} ago';
  } else {
    final years = difference.inDays ~/ 365;
    return '${years} year${years == 1 ? '' : 's'} ago';
  }
}

/// Formats a timestamp as time until with more precision.
String humanizeTimeUntil(DateTime dateTime, {DateTime? now}) {
  now ??= DateTime.now();
  final difference = dateTime.difference(now);
  
  if (difference.isNegative) {
    return humanizeTimeAgo(dateTime, now: now);
  }
  
  if (difference.inSeconds < 60) {
    return 'in a few seconds';
  } else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return 'in ${minutes} minute${minutes == 1 ? '' : 's'}';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return 'in ${hours} hour${hours == 1 ? '' : 's'}';
  } else if (difference.inDays < 7) {
    final days = difference.inDays;
    return 'in ${days} day${days == 1 ? '' : 's'}';
  } else if (difference.inDays < 30) {
    final weeks = difference.inDays ~/ 7;
    return 'in ${weeks} week${weeks == 1 ? '' : 's'}';
  } else if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    return 'in ${months} month${months == 1 ? '' : 's'}';
  } else {
    final years = difference.inDays ~/ 365;
    return 'in ${years} year${years == 1 ? '' : 's'}';
  }
}

/// Formats a date range in a human-readable way.
String humanizeDateRange(DateTime start, DateTime end) {
  final startDate = DateTime(start.year, start.month, start.day);
  final endDate = DateTime(end.year, end.month, end.day);
  
  if (startDate == endDate) {
    return 'on ${_formatDate(start)}';
  }
  
  final difference = endDate.difference(startDate).inDays;
  
  if (difference == 1) {
    return 'from ${_formatDate(start)} to ${_formatDate(end)}';
  }
  
  return 'from ${_formatDate(start)} to ${_formatDate(end)} (${difference + 1} days)';
}

/// Formats a timezone offset.
String humanizeTimezone(Duration offset) {
  final hours = offset.inHours;
  final minutes = offset.inMinutes.abs() % 60;
  final sign = hours >= 0 ? '+' : '-';
  
  return 'UTC$sign${hours.abs().toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

/// Formats uptime duration.
String humanizeUptime(Duration uptime) {
  final days = uptime.inDays;
  final hours = uptime.inHours % 24;
  final minutes = uptime.inMinutes % 60;
  final seconds = uptime.inSeconds % 60;
  
  final parts = <String>[];
  
  if (days > 0) {
    parts.add('${days}d');
  }
  if (hours > 0) {
    parts.add('${hours}h');
  }
  if (minutes > 0) {
    parts.add('${minutes}m');
  }
  if (seconds > 0 || parts.isEmpty) {
    parts.add('${seconds}s');
  }
  
  return parts.join(' ');
}

/// Formats age from birth date.
String humanizeAge(DateTime birthDate, {DateTime? now}) {
  now ??= DateTime.now();
  
  var years = now.year - birthDate.year;
  var months = now.month - birthDate.month;
  var days = now.day - birthDate.day;
  
  if (days < 0) {
    months--;
    days += DateTime(now.year, now.month, 0).day;
  }
  
  if (months < 0) {
    years--;
    months += 12;
  }
  
  if (years > 0) {
    if (months > 0) {
      return '${years}y ${months}mo';
    }
    return '${years}y';
  } else if (months > 0) {
    if (days > 0) {
      return '${months}mo ${days}d';
    }
    return '${months}mo';
  } else {
    return '${days}d';
  }
}

/// Helper function to format a date.
String _formatDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

/// Formats a duration as a countdown timer (HH:MM:SS).
String humanizeCountdown(Duration duration) {
  if (duration.isNegative) {
    return '00:00:00';
  }
  
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;
  
  if (hours > 0) {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  } else {
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

/// Formats a duration as a stopwatch timer (MM:SS.mmm).
String humanizeStopwatch(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;
  final milliseconds = duration.inMilliseconds % 1000;
  
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(3, '0')}';
}