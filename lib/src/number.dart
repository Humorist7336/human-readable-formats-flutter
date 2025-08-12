/// Formats a number with thousands separators (e.g., 1,234,567).
String humanizeNumber(num number, {String separator = ','}) {
  final parts = number.toString().split('.');
  final integerPart = parts[0];
  final decimalPart = parts.length > 1 ? parts[1] : '';
  
  // Add thousands separators
  final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  final formattedInteger = integerPart.replaceAllMapped(regex, (match) => '${match.group(1)}$separator');
  
  return decimalPart.isEmpty ? formattedInteger : '$formattedInteger.$decimalPart';
}

/// Formats a number as a scientific notation string (e.g., 1.23e+6).
String humanizeScientific(num number, {int precision = 2}) {
  return number.toStringAsExponential(precision);
}

/// Formats a number as a binary string (e.g., 1010).
String humanizeBinary(int number) {
  return number.toRadixString(2);
}

/// Formats a number as a hexadecimal string (e.g., FF).
String humanizeHex(int number, {bool uppercase = true}) {
  final hex = number.toRadixString(16);
  return uppercase ? hex.toUpperCase() : hex;
}

/// Formats a number as an octal string (e.g., 777).
String humanizeOctal(int number) {
  return number.toRadixString(8);
}

/// Formats a number with a specific number of decimal places.
String humanizeDecimal(num number, {int decimalPlaces = 2}) {
  return number.toStringAsFixed(decimalPlaces);
}

/// Formats a number as a Roman numeral (1-3999).
String humanizeRoman(int number) {
  if (number <= 0 || number > 3999) {
    throw ArgumentError('Roman numerals only support numbers from 1 to 3999');
  }
  
  const values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
  const numerals = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'];
  
  final result = StringBuffer();
  var remaining = number;
  
  for (int i = 0; i < values.length; i++) {
    while (remaining >= values[i]) {
      result.write(numerals[i]);
      remaining -= values[i];
    }
  }
  
  return result.toString();
}

/// Formats a number with appropriate magnitude suffix (B, M, K, etc.).
String humanizeMagnitude(num number, {int precision = 1}) {
  if (number.abs() < 1000) {
    return number.toString();
  }
  
  const suffixes = ['', 'K', 'M', 'B', 'T', 'P', 'E'];
  var magnitude = 0;
  var value = number.toDouble();
  
  while (value.abs() >= 1000 && magnitude < suffixes.length - 1) {
    value /= 1000;
    magnitude++;
  }
  
  return '${value.toStringAsFixed(precision)}${suffixes[magnitude]}';
}

/// Formats a number as a fraction string (e.g., 3/4).
String humanizeFraction(double number, {int maxDenominator = 100}) {
  if (number == number.truncate()) {
    return number.truncate().toString();
  }
  
  var bestNumerator = 1;
  var bestDenominator = 1;
  var minError = double.infinity;
  
  for (int denominator = 1; denominator <= maxDenominator; denominator++) {
    final numerator = (number * denominator).round();
    final error = (number - numerator / denominator).abs();
    
    if (error < minError) {
      minError = error;
      bestNumerator = numerator;
      bestDenominator = denominator;
    }
    
    if (error == 0) break;
  }
  
  // Simplify the fraction
  final gcd = _gcd(bestNumerator.abs(), bestDenominator);
  bestNumerator ~/= gcd;
  bestDenominator ~/= gcd;
  
  if (bestDenominator == 1) {
    return bestNumerator.toString();
  }
  
  return '$bestNumerator/$bestDenominator';
}

/// Calculates the greatest common divisor of two integers.
int _gcd(int a, int b) {
  while (b != 0) {
    final temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}

/// Formats a number with appropriate unit prefix (metric).
String humanizeMetric(num number, {String unit = '', int precision = 2}) {
  const prefixes = [
    {'factor': 1e24, 'symbol': 'Y'},  // yotta
    {'factor': 1e21, 'symbol': 'Z'},  // zetta
    {'factor': 1e18, 'symbol': 'E'},  // exa
    {'factor': 1e15, 'symbol': 'P'},  // peta
    {'factor': 1e12, 'symbol': 'T'},  // tera
    {'factor': 1e9, 'symbol': 'G'},   // giga
    {'factor': 1e6, 'symbol': 'M'},   // mega
    {'factor': 1e3, 'symbol': 'k'},   // kilo
    {'factor': 1, 'symbol': ''},      // base
    {'factor': 1e-3, 'symbol': 'm'},  // milli
    {'factor': 1e-6, 'symbol': 'μ'},  // micro
    {'factor': 1e-9, 'symbol': 'n'},  // nano
    {'factor': 1e-12, 'symbol': 'p'}, // pico
    {'factor': 1e-15, 'symbol': 'f'}, // femto
    {'factor': 1e-18, 'symbol': 'a'}, // atto
    {'factor': 1e-21, 'symbol': 'z'}, // zepto
    {'factor': 1e-24, 'symbol': 'y'}, // yocto
  ];
  
  final absNumber = number.abs();
  
  for (final prefix in prefixes) {
    final factor = (prefix['factor'] as num).toDouble();
    if (absNumber >= factor) {
      final value = number.toDouble() / factor;
      final symbol = prefix['symbol'] as String;
      return '${value.toStringAsFixed(precision)}${symbol}${unit}';
    }
  }
  
  return '${number.toStringAsFixed(precision)}${unit}';
}