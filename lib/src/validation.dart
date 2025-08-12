/// Validation utilities for human-readable formats.

/// Validates if a string represents a valid file size format.
bool isValidFileSize(String input) {
  final regex = RegExp(r'^\d+(\.\d+)?\s*(B|KB|MB|GB|TB|PB|KiB|MiB|GiB|TiB|PiB)$', caseSensitive: false);
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid duration format.
bool isValidDuration(String input) {
  final regex = RegExp(r'^(\d+[yY])?(\d+[mM][oO])?(\d+[wW])?(\d+[dD])?(\d+[hH])?(\d+[mM])?(\d+[sS])?$');
  final cleaned = input.replaceAll(RegExp(r'\s+'), '');
  return regex.hasMatch(cleaned) && cleaned.isNotEmpty;
}

/// Validates if a string represents a valid percentage format.
bool isValidPercentage(String input) {
  final regex = RegExp(r'^\d+(\.\d+)?%$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid currency format.
bool isValidCurrency(String input) {
  final regex = RegExp(r'^[₹$€£¥₩₽₨₪₫₡₦₵₴₸₼₾₿]\d{1,3}(,\d{3})*(\.\d{2})?$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid ratio format.
bool isValidRatio(String input) {
  final regex = RegExp(r'^\d+(\.\d+)?:\d+(\.\d+)?$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid compact number format.
bool isValidCompactNumber(String input) {
  final regex = RegExp(r'^\d+(\.\d+)?[KMBTPE]?$', caseSensitive: false);
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid hexadecimal number.
bool isValidHex(String input) {
  final regex = RegExp(r'^[0-9A-Fa-f]+$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid binary number.
bool isValidBinary(String input) {
  final regex = RegExp(r'^[01]+$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid octal number.
bool isValidOctal(String input) {
  final regex = RegExp(r'^[0-7]+$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid Roman numeral.
bool isValidRoman(String input) {
  final regex = RegExp(r'^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$');
  return regex.hasMatch(input.trim().toUpperCase());
}

/// Validates if a string represents a valid scientific notation.
bool isValidScientific(String input) {
  final regex = RegExp(r'^\d+(\.\d+)?[eE][+-]?\d+$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid fraction.
bool isValidFraction(String input) {
  final regex = RegExp(r'^\d+\/\d+$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid time format (12-hour).
bool isValidTime12Hour(String input) {
  final regex = RegExp(r'^(0?[1-9]|1[0-2]):[0-5][0-9]\s?(AM|PM)$', caseSensitive: false);
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid time format (24-hour).
bool isValidTime24Hour(String input) {
  final regex = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid timezone offset.
bool isValidTimezone(String input) {
  final regex = RegExp(r'^UTC[+-]([01]?[0-9]|2[0-3]):[0-5][0-9]$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid IP address (IPv4).
bool isValidIPv4(String input) {
  final regex = RegExp(r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid IP address (IPv6).
bool isValidIPv6(String input) {
  final regex = RegExp(r'^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid MAC address.
bool isValidMACAddress(String input) {
  final regex = RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid URL.
bool isValidURL(String input) {
  try {
    final uri = Uri.parse(input.trim());
    return uri.hasScheme && uri.hasAuthority;
  } catch (e) {
    return false;
  }
}

/// Validates if a string represents a valid email address.
bool isValidEmail(String input) {
  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid phone number (basic format).
bool isValidPhoneNumber(String input) {
  final regex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid credit card number (Luhn algorithm).
bool isValidCreditCard(String input) {
  final cleaned = input.replaceAll(RegExp(r'\D'), '');
  
  if (cleaned.length < 13 || cleaned.length > 19) {
    return false;
  }
  
  // Luhn algorithm
  var sum = 0;
  var alternate = false;
  
  for (int i = cleaned.length - 1; i >= 0; i--) {
    var digit = int.parse(cleaned[i]);
    
    if (alternate) {
      digit *= 2;
      if (digit > 9) {
        digit = (digit % 10) + 1;
      }
    }
    
    sum += digit;
    alternate = !alternate;
  }
  
  return sum % 10 == 0;
}

/// Validates if a string represents a valid postal code (US ZIP).
bool isValidUSZipCode(String input) {
  final regex = RegExp(r'^\d{5}(-\d{4})?$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid postal code (UK).
bool isValidUKPostalCode(String input) {
  final regex = RegExp(r'^[A-Z]{1,2}[0-9R][0-9A-Z]?\s?[0-9][A-Z]{2}$', caseSensitive: false);
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid Canadian postal code.
bool isValidCanadianPostalCode(String input) {
  final regex = RegExp(r'^[A-Z]\d[A-Z]\s?\d[A-Z]\d$', caseSensitive: false);
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid color hex code.
bool isValidColorHex(String input) {
  final regex = RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$');
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid RGB color.
bool isValidColorRGB(String input) {
  final regex = RegExp(r'^rgb\(\s*([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\s*,\s*([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\s*,\s*([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\s*\)$', caseSensitive: false);
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid RGBA color.
bool isValidColorRGBA(String input) {
  final regex = RegExp(r'^rgba\(\s*([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\s*,\s*([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\s*,\s*([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\s*,\s*(0|1|0?\.\d+)\s*\)$', caseSensitive: false);
  return regex.hasMatch(input.trim());
}

/// Validates if a string represents a valid HSL color.
bool isValidColorHSL(String input) {
  final regex = RegExp(r'^hsl\(\s*(360|3[0-5][0-9]|[12][0-9][0-9]|[1-9]?[0-9])\s*,\s*(100|[1-9]?[0-9])%\s*,\s*(100|[1-9]?[0-9])%\s*\)$', caseSensitive: false);
  return regex.hasMatch(input.trim());
}

/// Validates if a number is within a specific range.
bool isNumberInRange(num value, num min, num max) {
  return value >= min && value <= max;
}

/// Validates if a string length is within a specific range.
bool isStringLengthInRange(String value, int min, int max) {
  return value.length >= min && value.length <= max;
}

/// Validates if a date is within a specific range.
bool isDateInRange(DateTime date, DateTime start, DateTime end) {
  return date.isAfter(start) && date.isBefore(end) || date.isAtSameMomentAs(start) || date.isAtSameMomentAs(end);
}