import 'package:test/test.dart';
import 'package:human_readable_formats/src/scientific.dart';

void main() {
  group('humanizeScientificNotation', () {
    test('formats basic scientific notation', () {
      expect(humanizeScientificNotation(1234.5), '1.23 × 10³');
      expect(humanizeScientificNotation(0.00123), '1.23 × 10⁻³');
      expect(humanizeScientificNotation(0), '0');
    });

    test('handles custom precision', () {
      expect(humanizeScientificNotation(1234.5, precision: 1), '1.2 × 10³');
      expect(humanizeScientificNotation(1234.5, precision: 3), '1.234 × 10³');
    });

    test('handles non-unicode format', () {
      expect(humanizeScientificNotation(1234.5, useUnicode: false), '1.23 × 10e3');
    });
  });

  group('humanizeEngineeringNotation', () {
    test('formats engineering notation', () {
      expect(humanizeEngineeringNotation(1234), '1.23 × 10^3');
      expect(humanizeEngineeringNotation(1234567), '1.23 × 10^6');
      expect(humanizeEngineeringNotation(0.001234), '1.23 × 10^-3');
    });

    test('handles values without exponent', () {
      expect(humanizeEngineeringNotation(123), '123.00');
      expect(humanizeEngineeringNotation(0), '0');
    });
  });

  group('humanizeChemicalFormula', () {
    test('formats chemical formulas with subscripts', () {
      expect(humanizeChemicalFormula('H2O'), 'H₂O');
      expect(humanizeChemicalFormula('C6H12O6'), 'C₆H₁₂O₆');
      expect(humanizeChemicalFormula('CaCl2'), 'CaCl₂');
    });
  });

  group('humanizeMathExpression', () {
    test('formats mathematical expressions', () {
      expect(humanizeMathExpression('x^2'), 'x²');
      expect(humanizeMathExpression('a_1'), 'a₁');
      expect(humanizeMathExpression('x^2 + y_3'), 'x² + y₃');
    });
  });

  group('humanizePhysicalConstant', () {
    test('formats physical constants', () {
      expect(humanizePhysicalConstant('Speed of light', 299792458, 'm/s'), 
             'Speed of light = 299792458.000000 m/s');
      expect(humanizePhysicalConstant('Planck constant', 6.62607015e-34, 'J⋅s', precision: 8), 
             'Planck constant = 0.00000000 J⋅s');
    });
  });

  group('humanizeWavelength', () {
    test('formats wavelengths in appropriate units', () {
      expect(humanizeWavelength(0.001), '1.0 mm');
      expect(humanizeWavelength(500e-9), '500.0 nm');
      expect(humanizeWavelength(1e-6), '1.0 μm');
      expect(humanizeWavelength(1e-12), '1.0 pm');
    });
  });

  group('humanizeEnergy', () {
    test('formats energy in appropriate units', () {
      expect(humanizeEnergy(1e9), '1.00 GJ');
      expect(humanizeEnergy(1e6), '1.00 MJ');
      expect(humanizeEnergy(1000), '1.00 kJ');
      expect(humanizeEnergy(1), '1.00 J');
      expect(humanizeEnergy(0.001), '1.00 mJ');
      expect(humanizeEnergy(1e-6), '1.00 μJ');
      expect(humanizeEnergy(1e-9), '1.00 nJ');
    });
  });

  group('humanizePower', () {
    test('formats power in appropriate units', () {
      expect(humanizePower(1e12), '1.00 TW');
      expect(humanizePower(1e9), '1.00 GW');
      expect(humanizePower(1e6), '1.00 MW');
      expect(humanizePower(1000), '1.00 kW');
      expect(humanizePower(1), '1.00 W');
      expect(humanizePower(0.001), '1.00 mW');
      expect(humanizePower(1e-6), '1.00 μW');
      expect(humanizePower(1e-9), '1.00 nW');
    });
  });

  group('humanizeCurrent', () {
    test('formats electric current in appropriate units', () {
      expect(humanizeCurrent(1000), '1.00 kA');
      expect(humanizeCurrent(1), '1.000 A');
      expect(humanizeCurrent(0.001), '1.00 mA');
      expect(humanizeCurrent(1e-6), '1.00 μA');
      expect(humanizeCurrent(1e-9), '1.00 nA');
    });
  });

  group('humanizeVoltage', () {
    test('formats voltage in appropriate units', () {
      expect(humanizeVoltage(1e6), '1.00 MV');
      expect(humanizeVoltage(1000), '1.00 kV');
      expect(humanizeVoltage(1), '1.00 V');
      expect(humanizeVoltage(0.001), '1.00 mV');
      expect(humanizeVoltage(1e-6), '1.00 μV');
    });
  });

  group('humanizeResistance', () {
    test('formats resistance in appropriate units', () {
      expect(humanizeResistance(1e9), '1.00 GΩ');
      expect(humanizeResistance(1e6), '1.00 MΩ');
      expect(humanizeResistance(1000), '1.00 kΩ');
      expect(humanizeResistance(1), '1.00 Ω');
      expect(humanizeResistance(0.001), '1.00 mΩ');
    });
  });

  group('humanizeCapacitance', () {
    test('formats capacitance in appropriate units', () {
      expect(humanizeCapacitance(1), '1.000 F');
      expect(humanizeCapacitance(0.001), '1.00 mF');
      expect(humanizeCapacitance(1e-6), '1.00 μF');
      expect(humanizeCapacitance(1e-9), '1.00 nF');
      expect(humanizeCapacitance(1e-12), '1.00 pF');
    });
  });

  group('humanizeInductance', () {
    test('formats inductance in appropriate units', () {
      expect(humanizeInductance(1), '1.000 H');
      expect(humanizeInductance(0.001), '1.00 mH');
      expect(humanizeInductance(1e-6), '1.00 μH');
      expect(humanizeInductance(1e-9), '1.00 nH');
    });
  });

  group('humanizeTemperature', () {
    test('formats temperature in different scales', () {
      expect(humanizeTemperature(273.15, scale: 'celsius'), '0.0°C');
      expect(humanizeTemperature(273.15, scale: 'fahrenheit'), '32.0°F');
      expect(humanizeTemperature(273.15, scale: 'kelvin'), '273.1 K');
    });

    test('auto-selects appropriate scale', () {
      expect(humanizeTemperature(50), '50.0 K'); // Very cold
      expect(humanizeTemperature(300), '26.9°C'); // Room temperature
      expect(humanizeTemperature(2000), '2000 K'); // Very hot
    });
  });

  group('humanizePressure', () {
    test('formats pressure in appropriate units', () {
      expect(humanizePressure(1e9), '1.00 GPa');
      expect(humanizePressure(1e6), '1.00 MPa');
      expect(humanizePressure(1000), '1.00 kPa');
      expect(humanizePressure(101325), '101.33 kPa'); // Standard atmospheric pressure
      expect(humanizePressure(100), '1.00 hPa');
    });
  });

  group('humanizeAtomicMass', () {
    test('formats atomic mass units', () {
      expect(humanizeAtomicMass(12.011), '12.011 u'); // Carbon-12
      expect(humanizeAtomicMass(0.000549), '0.000549 u'); // Electron
    });
  });

  group('humanizeRadioactivity', () {
    test('formats radioactivity in appropriate units', () {
      expect(humanizeRadioactivity(1e12), '1.00 TBq');
      expect(humanizeRadioactivity(1e9), '1.00 GBq');
      expect(humanizeRadioactivity(1e6), '1.00 MBq');
      expect(humanizeRadioactivity(1000), '1.00 kBq');
      expect(humanizeRadioactivity(100), '100.00 Bq');
    });
  });
}