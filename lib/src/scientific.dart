/// Scientific and technical formatting utilities.
import 'dart:math' as math;

/// Formats scientific notation with proper exponent formatting.
String humanizeScientificNotation(double value, {int precision = 2, bool useUnicode = true}) {
  if (value == 0) return '0';
  
  final exponent = (math.log(value.abs()) / math.ln10).floor();
  final mantissa = value / math.pow(10, exponent);
  
  final mantissaStr = mantissa.toStringAsFixed(precision);
  final expStr = useUnicode ? _formatExponentUnicode(exponent) : 'e$exponent';
  
  return '$mantissaStr × 10$expStr';
}

/// Formats engineering notation (exponents in multiples of 3).
String humanizeEngineeringNotation(double value, {int precision = 2}) {
  if (value == 0) return '0';
  
  final exponent = (math.log(value.abs()) / math.ln10).floor();
  final engExponent = (exponent / 3).floor() * 3;
  final mantissa = value / math.pow(10, engExponent);
  
  final mantissaStr = mantissa.toStringAsFixed(precision);
  return engExponent == 0 ? mantissaStr : '$mantissaStr × 10^$engExponent';
}

/// Formats chemical formulas with proper subscripts.
String humanizeChemicalFormula(String formula) {
  return formula.replaceAllMapped(RegExp(r'(\d+)'), (match) {
    final number = match.group(1)!;
    return _formatSubscript(number);
  });
}

/// Formats mathematical expressions with proper superscripts and subscripts.
String humanizeMathExpression(String expression) {
  // Handle superscripts (^)
  expression = expression.replaceAllMapped(RegExp(r'\^(\d+)'), (match) {
    final number = match.group(1)!;
    return _formatSuperscript(number);
  });
  
  // Handle subscripts (_)
  expression = expression.replaceAllMapped(RegExp(r'_(\d+)'), (match) {
    final number = match.group(1)!;
    return _formatSubscript(number);
  });
  
  return expression;
}

/// Formats physical constants with proper units and precision.
String humanizePhysicalConstant(String constantName, double value, String unit, {int precision = 6}) {
  final valueStr = value.toStringAsFixed(precision);
  return '$constantName = $valueStr $unit';
}

/// Formats wavelength with appropriate units.
String humanizeWavelength(double meters) {
  if (meters >= 1e-3) {
    return '${(meters * 1000).toStringAsFixed(1)} mm';
  } else if (meters >= 1e-6) {
    return '${(meters * 1e6).toStringAsFixed(1)} μm';
  } else if (meters >= 1e-9) {
    return '${(meters * 1e9).toStringAsFixed(1)} nm';
  } else if (meters >= 1e-12) {
    return '${(meters * 1e12).toStringAsFixed(1)} pm';
  } else {
    return '${meters.toStringAsFixed(2)} m';
  }
}

/// Formats energy in appropriate units.
String humanizeEnergy(double joules) {
  if (joules >= 1e9) {
    return '${(joules / 1e9).toStringAsFixed(2)} GJ';
  } else if (joules >= 1e6) {
    return '${(joules / 1e6).toStringAsFixed(2)} MJ';
  } else if (joules >= 1e3) {
    return '${(joules / 1e3).toStringAsFixed(2)} kJ';
  } else if (joules >= 1) {
    return '${joules.toStringAsFixed(2)} J';
  } else if (joules >= 1e-3) {
    return '${(joules * 1e3).toStringAsFixed(2)} mJ';
  } else if (joules >= 1e-6) {
    return '${(joules * 1e6).toStringAsFixed(2)} μJ';
  } else if (joules >= 1e-9) {
    return '${(joules * 1e9).toStringAsFixed(2)} nJ';
  } else {
    return '${joules.toStringAsFixed(6)} J';
  }
}

/// Formats power in appropriate units.
String humanizePower(double watts) {
  if (watts >= 1e12) {
    return '${(watts / 1e12).toStringAsFixed(2)} TW';
  } else if (watts >= 1e9) {
    return '${(watts / 1e9).toStringAsFixed(2)} GW';
  } else if (watts >= 1e6) {
    return '${(watts / 1e6).toStringAsFixed(2)} MW';
  } else if (watts >= 1e3) {
    return '${(watts / 1e3).toStringAsFixed(2)} kW';
  } else if (watts >= 1) {
    return '${watts.toStringAsFixed(2)} W';
  } else if (watts >= 1e-3) {
    return '${(watts * 1e3).toStringAsFixed(2)} mW';
  } else if (watts >= 1e-6) {
    return '${(watts * 1e6).toStringAsFixed(2)} μW';
  } else if (watts >= 1e-9) {
    return '${(watts * 1e9).toStringAsFixed(2)} nW';
  } else {
    return '${watts.toStringAsFixed(6)} W';
  }
}

/// Formats electric current in appropriate units.
String humanizeCurrent(double amperes) {
  if (amperes >= 1e3) {
    return '${(amperes / 1e3).toStringAsFixed(2)} kA';
  } else if (amperes >= 1) {
    return '${amperes.toStringAsFixed(3)} A';
  } else if (amperes >= 1e-3) {
    return '${(amperes * 1e3).toStringAsFixed(2)} mA';
  } else if (amperes >= 1e-6) {
    return '${(amperes * 1e6).toStringAsFixed(2)} μA';
  } else if (amperes >= 1e-9) {
    return '${(amperes * 1e9).toStringAsFixed(2)} nA';
  } else {
    return '${amperes.toStringAsFixed(6)} A';
  }
}

/// Formats voltage in appropriate units.
String humanizeVoltage(double volts) {
  if (volts >= 1e6) {
    return '${(volts / 1e6).toStringAsFixed(2)} MV';
  } else if (volts >= 1e3) {
    return '${(volts / 1e3).toStringAsFixed(2)} kV';
  } else if (volts >= 1) {
    return '${volts.toStringAsFixed(2)} V';
  } else if (volts >= 1e-3) {
    return '${(volts * 1e3).toStringAsFixed(2)} mV';
  } else if (volts >= 1e-6) {
    return '${(volts * 1e6).toStringAsFixed(2)} μV';
  } else {
    return '${volts.toStringAsFixed(6)} V';
  }
}

/// Formats resistance in appropriate units.
String humanizeResistance(double ohms) {
  if (ohms >= 1e9) {
    return '${(ohms / 1e9).toStringAsFixed(2)} GΩ';
  } else if (ohms >= 1e6) {
    return '${(ohms / 1e6).toStringAsFixed(2)} MΩ';
  } else if (ohms >= 1e3) {
    return '${(ohms / 1e3).toStringAsFixed(2)} kΩ';
  } else if (ohms >= 1) {
    return '${ohms.toStringAsFixed(2)} Ω';
  } else if (ohms >= 1e-3) {
    return '${(ohms * 1e3).toStringAsFixed(2)} mΩ';
  } else {
    return '${ohms.toStringAsFixed(6)} Ω';
  }
}

/// Formats capacitance in appropriate units.
String humanizeCapacitance(double farads) {
  if (farads >= 1) {
    return '${farads.toStringAsFixed(3)} F';
  } else if (farads >= 1e-3) {
    return '${(farads * 1e3).toStringAsFixed(2)} mF';
  } else if (farads >= 1e-6) {
    return '${(farads * 1e6).toStringAsFixed(2)} μF';
  } else if (farads >= 1e-9) {
    return '${(farads * 1e9).toStringAsFixed(2)} nF';
  } else if (farads >= 1e-12) {
    return '${(farads * 1e12).toStringAsFixed(2)} pF';
  } else {
    return '${farads.toStringAsFixed(12)} F';
  }
}

/// Formats inductance in appropriate units.
String humanizeInductance(double henries) {
  if (henries >= 1) {
    return '${henries.toStringAsFixed(3)} H';
  } else if (henries >= 1e-3) {
    return '${(henries * 1e3).toStringAsFixed(2)} mH';
  } else if (henries >= 1e-6) {
    return '${(henries * 1e6).toStringAsFixed(2)} μH';
  } else if (henries >= 1e-9) {
    return '${(henries * 1e9).toStringAsFixed(2)} nH';
  } else {
    return '${henries.toStringAsFixed(9)} H';
  }
}

/// Formats temperature in various scales.
String humanizeTemperature(double kelvin, {String scale = 'auto'}) {
  switch (scale.toLowerCase()) {
    case 'celsius':
    case 'c':
      final celsius = kelvin - 273.15;
      return '${celsius.toStringAsFixed(1)}°C';
    case 'fahrenheit':
    case 'f':
      final fahrenheit = (kelvin - 273.15) * 9/5 + 32;
      return '${fahrenheit.toStringAsFixed(1)}°F';
    case 'kelvin':
    case 'k':
      return '${kelvin.toStringAsFixed(1)} K';
    case 'auto':
    default:
      if (kelvin < 100) {
        return '${kelvin.toStringAsFixed(1)} K';
      } else if (kelvin > 1000) {
        return '${kelvin.toStringAsFixed(0)} K';
      } else {
        final celsius = kelvin - 273.15;
        return '${celsius.toStringAsFixed(1)}°C';
      }
  }
}

/// Formats pressure in appropriate units.
String humanizePressure(double pascals) {
  if (pascals >= 1e9) {
    return '${(pascals / 1e9).toStringAsFixed(2)} GPa';
  } else if (pascals >= 1e6) {
    return '${(pascals / 1e6).toStringAsFixed(2)} MPa';
  } else if (pascals >= 1e3) {
    return '${(pascals / 1e3).toStringAsFixed(2)} kPa';
  } else if (pascals >= 100) {
    return '${(pascals / 100).toStringAsFixed(2)} hPa';
  } else {
    return '${pascals.toStringAsFixed(2)} Pa';
  }
}

/// Formats atomic mass in appropriate units.
String humanizeAtomicMass(double atomicMassUnits) {
  if (atomicMassUnits >= 1) {
    return '${atomicMassUnits.toStringAsFixed(3)} u';
  } else {
    return '${atomicMassUnits.toStringAsFixed(6)} u';
  }
}

/// Formats radioactivity in appropriate units.
String humanizeRadioactivity(double becquerels) {
  if (becquerels >= 1e12) {
    return '${(becquerels / 1e12).toStringAsFixed(2)} TBq';
  } else if (becquerels >= 1e9) {
    return '${(becquerels / 1e9).toStringAsFixed(2)} GBq';
  } else if (becquerels >= 1e6) {
    return '${(becquerels / 1e6).toStringAsFixed(2)} MBq';
  } else if (becquerels >= 1e3) {
    return '${(becquerels / 1e3).toStringAsFixed(2)} kBq';
  } else {
    return '${becquerels.toStringAsFixed(2)} Bq';
  }
}

/// Helper function to format exponents with Unicode superscripts.
String _formatExponentUnicode(int exponent) {
  const superscripts = {
    '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
    '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹',
    '-': '⁻', '+': '⁺'
  };
  
  return exponent.toString().split('').map((char) => superscripts[char] ?? char).join();
}

/// Helper function to format subscripts.
String _formatSubscript(String number) {
  const subscripts = {
    '0': '₀', '1': '₁', '2': '₂', '3': '₃', '4': '₄',
    '5': '₅', '6': '₆', '7': '₇', '8': '₈', '9': '₉'
  };
  
  return number.split('').map((char) => subscripts[char] ?? char).join();
}

/// Helper function to format superscripts.
String _formatSuperscript(String number) {
  const superscripts = {
    '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
    '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹'
  };
  
  return number.split('').map((char) => superscripts[char] ?? char).join();
}