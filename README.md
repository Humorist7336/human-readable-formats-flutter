# Human Readable Formats

[![pub package](https://img.shields.io/pub/v/human_readable_formats.svg)](https://pub.dev/packages/human_readable_formats)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Test](https://github.com/sdkwala/human-readable-formats-flutter/actions/workflows/test.yml/badge.svg)](https://github.com/sdkwala/human-readable-formats-flutter/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/sdkwala/human-readable-formats-flutter/graph/badge.svg?token=YOUR-TOKEN-HERE)](https://codecov.io/gh/sdkwala/human-readable-formats-flutter)

A comprehensive pure Dart package to format raw data into human-readable text. From basic numbers and dates to advanced scientific notation, geographic coordinates, network data, and complex data structures - this package provides 60+ specialized formatting functions. Platform-independent with no Flutter dependencies.

## Brought to you by SDKWala

This project is an open-source initiative by [SDKWala](https://www.sdkwala.com), a company dedicated to creating high-quality, developer-friendly SDKs and open-source projects. 

- **Website**: [www.sdkwala.com](https://www.sdkwala.com)
- **GitHub**: [https://github.com/sdkwala](https://github.com/sdkwala)

## Features

### 📊 **Core Data Formatting**
- **Numbers**: Format numbers with localization, ordinals, compact notation (e.g., "1.2K", "3rd", "1,234.56")
- **File Sizes**: Format bytes with SI/IEC standards (e.g., "1.5 MB", "2.3 GiB")
- **Durations**: Format time spans in multiple styles (e.g., "2h 30m", "2 hours and 30 minutes")
- **Dates & Times**: Friendly date formatting (e.g., "Today at 3:45 PM", "2 days ago")
- **Percentages & Ratios**: Format numbers as percentages or ratios (e.g., "75%", "3 out of 4")
- **Currencies**: Format monetary values with proper symbols and localization

### 🌐 **Network & Technical**
- **Network Data**: Bandwidth, latency, data rates, IP addresses, MAC addresses, URLs
- **Protocols**: HTTP status codes, network protocols, DNS records, SSL certificates
- **Performance**: Speed tests, packet loss, signal strength, WiFi channels

### 🗺️ **Geographic & Mapping**
- **Coordinates**: Decimal degrees, DMS, UTM, What3Words formatting
- **Distances & Areas**: Smart unit conversion (km/mi, m²/ft², etc.)
- **Elevations**: Height formatting with appropriate units
- **Navigation**: Bearings, magnetic declination, GPS accuracy
- **Locations**: Addresses, bounding boxes, timezones, regions

### 🔬 **Scientific & Technical**
- **Scientific Notation**: Unicode exponents and engineering notation
- **Physical Units**: Energy, power, voltage, current, resistance, capacitance
- **Chemistry**: Chemical formulas with proper subscripts (H₂O, C₆H₁₂O₆)
- **Physics**: Wavelengths, frequencies, temperatures, pressures
- **Mathematics**: Mathematical expressions with superscripts and subscripts

### 📋 **Data Structures**
- **Structured Data**: JSON, XML, CSV with proper formatting and alignment
- **Tables**: ASCII/Unicode tables with borders and indexing
- **Trees & Hierarchies**: Visual tree structures and hierarchical data
- **Lists & Matrices**: Formatted lists (bullet/numbered) and 2D arrays

### 🌍 **Localization & Configuration**
- **Multi-language**: Built-in English and Spanish support
- **Global Configuration**: Set defaults for locale, decimal places, and standards
- **Fluent API**: Chainable builder pattern for complex formatting

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  human_readable_formats: ^0.1.0  # Check for the latest version
```

Then, run `dart pub get`.

## Quick Start

```dart
import 'package:human_readable_formats/human_readable_formats.dart';

void main() {
  // Format file sizes
  print(humanizeFileSize(1572864)); // "1.5 MiB"
  
  // Format durations
  print(humanizeDuration(const Duration(hours: 2, minutes: 30))); // "2h 30m"
  
  // Format friendly dates
  final now = DateTime.now();
  print(humanizeFriendlyDate(now)); // "Today"
  
  // Format percentages
  print(humanizePercentage(0.75)); // "75%"
  
  // Format ratios
  print(humanizeRatio(3, 4)); // "3 out of 4"
}
```

## Comprehensive Usage

### Core Data Formatting

#### Numbers & File Sizes

```dart
import 'package:human_readable_formats/human_readable_formats.dart';

// Numbers
print(humanizeNumber(1234567)); // "1,234,567"
print(humanizeCompactNumber(1234567)); // "1.2M"
print(humanizeOrdinal(3)); // "3rd"

// File Sizes
print(humanizeFileSize(1536)); // "1.5 KB"
print(humanizeFileSize(1073741824)); // "1.0 GB"
print(humanizeFileSize(1073741824, standard: FileSizeStandard.iec)); // "1.0 GiB"
```

#### Durations & Dates

```dart
// Durations
print(humanizeDuration(Duration(hours: 2, minutes: 30))); // "2h 30m"
print(humanizeDuration(Duration(hours: 2, minutes: 30), style: DurationStyle.long)); // "2 hours and 30 minutes"

// Friendly Dates
print(humanizeFriendlyDate(DateTime.now())); // "Today at 3:45 PM"
print(humanizeFriendlyDate(DateTime.now().subtract(Duration(hours: 2)), style: FriendlyDateStyle.relative)); // "2 hours ago"
```

#### Percentages & Currencies

```dart
// Percentages & Ratios
print(humanizePercentage(0.75)); // "75%"
print(humanizeRatio(3, 4)); // "3 out of 4"

// Currencies
print(humanizeCurrency(1234.56, 'USD')); // "$1,234.56"
print(humanizeCurrency(1234.56, 'EUR')); // "€1,234.56"
```

### Network & Technical Formatting

```dart
// Network Data
print(humanizeBandwidth(1048576)); // "1.0 Mbps"
print(humanizeLatency(45)); // "45 ms"
print(humanizeDataRate(1073741824)); // "1.0 GB/s"

// IP Addresses & URLs
print(humanizeIPAddress('192.168.1.1')); // "192.168.1.1 (Private)"
print(humanizeMACAddress('00:1B:44:11:3A:B7')); // "00:1B:44:11:3A:B7 (Dell Inc.)"
print(humanizeURL('https://api.example.com/v1/users?page=1')); // "api.example.com/v1/users"

// Network Performance
print(humanizeSpeedTest(downloadSpeed: 50000000, uploadSpeed: 10000000, ping: 25)); 
// "Download: 50.0 Mbps, Upload: 10.0 Mbps, Ping: 25 ms"

print(humanizeSignalStrength(-65)); // "Good (-65 dBm)"
print(humanizeWiFiChannel(6)); // "Channel 6 (2.437 GHz)"
```

### Geographic & Mapping

```dart
// Coordinates
print(humanizeCoordinates(40.7128, -74.0060)); // "40.7128°N, 74.0060°W"
print(humanizeCoordinatesDMS(40.7128, -74.0060)); // "40°42'46\"N, 74°0'22\"W"

// Distances & Areas
print(humanizeDistance(1500)); // "1.5 km"
print(humanizeDistance(500, unit: DistanceUnit.feet)); // "1,640 ft"
print(humanizeArea(1000000)); // "1.0 km²"

// Navigation & Location
print(humanizeBearing(45.5)); // "45.5° NE"
print(humanizeElevation(1500)); // "1,500 m"
print(humanizeTimezone('America/New_York')); // "Eastern Time (UTC-5)"
```

### Scientific & Technical

```dart
// Scientific Notation
print(humanizeScientificNotation(1234.5)); // "1.235 × 10³"
print(humanizeEngineeringNotation(1234500)); // "1.235 × 10⁶"

// Chemistry & Physics
print(humanizeChemicalFormula('H2O')); // "H₂O"
print(humanizeChemicalFormula('C6H12O6')); // "C₆H₁₂O₆"
print(humanizeMathExpression('x^2 + y^2 = z^2')); // "x² + y² = z²"

// Physical Units
print(humanizeEnergy(1000)); // "1.0 kJ"
print(humanizePower(1500)); // "1.5 kW"
print(humanizeTemperature(273.15)); // "273.1 K"
print(humanizePressure(101325)); // "101.33 kPa"
print(humanizeWavelength(550e-9)); // "550 nm"
```

### Data Structures

```dart
// JSON & XML
Map<String, dynamic> data = {'name': 'John', 'age': 30, 'city': 'NYC'};
print(humanizeJSON(data));
// {
//   "name": "John",
//   "age": 30,
//   "city": "NYC"
// }

// Tables
List<List<String>> tableData = [
  ['Name', 'Age', 'City'],
  ['John', '30', 'NYC'],
  ['Jane', '25', 'LA']
];
print(humanizeTable(tableData));
// ┌──────┬─────┬─────┐
// │ Name │ Age │ City│
// ├──────┼─────┼─────┤
// │ John │ 30  │ NYC │
// │ Jane │ 25  │ LA  │
// └──────┴─────┴─────┘

// Trees & Hierarchies
Map<String, dynamic> tree = {
  'root': {
    'child1': {},
    'child2': {'grandchild': {}}
  }
};
print(humanizeTree(tree));
// └── root
//     ├── child1
//     └── child2
//         └── grandchild

// Lists & Matrices
print(humanizeListStructure(['item1', 'item2', 'item3'], style: ListStyle.bullet));
// • item1
// • item2
// • item3

List<List<int>> matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
print(humanizeMatrix(matrix));
// [1, 2, 3]
// [4, 5, 6]
// [7, 8, 9]
```

## Global Configuration

Set default values that apply throughout your app:

```dart
void main() {
  // Set global defaults
  HumanReadableConfig.instance
    ..locale = 'es'  // Default to Spanish
    ..decimalPlaces = 2
    ..fileSizeStandard = FileSizeStandard.si;
    
  // Now all formatting functions will use these defaults
  print(humanizeFileSize(1000)); // "1.00 KB" (SI units)
  print(humanizePercentage(0.5)); // "50.00%"
}
```

## Migration Guide

### From v0.0.x to v0.1.0

The package has been significantly updated with new features and improvements. Here are the key changes:

1. **New Features**:
   - Added file size formatting with support for SI and IEC standards
   - Added duration formatting with short and long styles
   - Added friendly date formatting
   - Added percentage and ratio formatting
   - Added localization support (English and Spanish)
   - Added global configuration
   - Added fluent builder API

2. **Breaking Changes**:
   - Removed Flutter widget dependencies (now pure Dart)
   - Moved to using `FileSizeStandard` enum instead of boolean flags
   - Changed default decimal places behavior to be more intuitive

3. **Migration Steps**:
   - Update your imports if you were using Flutter-specific widgets
   - If you were using custom formatting, update to use the new builder API
   - Test your app thoroughly as the behavior of some formatters may have changed slightly

## API Reference

### Core Data Functions

#### Numbers
- `humanizeNumber(num value, {String? locale})` - Format numbers with localization
- `humanizeCompactNumber(num value, {int? decimalPlaces, String? locale})` - Compact notation (1.2K, 3.4M)
- `humanizeOrdinal(int number, {String? locale})` - Ordinal numbers (1st, 2nd, 3rd)

#### File Sizes
- `humanizeFileSize(int bytes, {int? decimalPlaces, FileSizeStandard? standard, String? locale})`
- `FileSizeFormatter` class with fluent API

#### Durations & Dates
- `humanizeDuration(Duration duration, {DurationStyle? style, int? maxUnits, String? locale})`
- `humanizeFriendlyDate(DateTime date, {FriendlyDateStyle? style, TimeFormat? timeFormat, String? locale})`
- `DurationFormatter` and `FriendlyDateFormatter` classes with fluent APIs

#### Percentages & Currencies
- `humanizePercentage(double value, {int? decimalPlaces, String? symbol, String? locale})`
- `humanizeRatio(int numerator, int denominator, {RatioStyle? style, String? locale})`
- `humanizeCurrency(double amount, String currencyCode, {int? decimalPlaces, String? locale})`

### Network & Technical Functions

#### Network Data
- `humanizeBandwidth(int bitsPerSecond, {int? decimalPlaces})` - Format bandwidth
- `humanizeLatency(int milliseconds)` - Format network latency
- `humanizeDataRate(int bytesPerSecond, {int? decimalPlaces})` - Format data transfer rates
- `humanizePacketLoss(double percentage)` - Format packet loss percentage

#### Network Addresses
- `humanizeIPAddress(String ipAddress)` - Format IP addresses with type detection
- `humanizeMACAddress(String macAddress)` - Format MAC addresses with vendor lookup
- `humanizeURL(String url, {bool showProtocol = false})` - Clean URL formatting

#### Network Performance
- `humanizeSpeedTest({required int downloadSpeed, required int uploadSpeed, required int ping})`
- `humanizeSignalStrength(int dbm)` - WiFi/cellular signal strength
- `humanizeWiFiChannel(int channel)` - WiFi channel with frequency

### Geographic Functions

#### Coordinates
- `humanizeCoordinates(double latitude, double longitude, {int? precision})`
- `humanizeCoordinatesDMS(double latitude, double longitude)` - Degrees, Minutes, Seconds
- `humanizeUTMCoordinates(double easting, double northing, int zone, String band)`
- `humanizeWhat3Words(String words)` - What3Words address formatting

#### Distances & Areas
- `humanizeDistance(double meters, {DistanceUnit? unit, int? decimalPlaces})`
- `humanizeArea(double squareMeters, {AreaUnit? unit, int? decimalPlaces})`
- `humanizeElevation(double meters, {ElevationUnit? unit})`

#### Navigation & Location
- `humanizeBearing(double degrees)` - Compass bearing with direction
- `humanizeGPSAccuracy(double meters)` - GPS accuracy description
- `humanizeTimezone(String timezone)` - Timezone with UTC offset
- `humanizeAddress(Map<String, String> components)` - Structured address formatting

### Scientific Functions

#### Scientific Notation
- `humanizeScientificNotation(double value, {int? precision})` - Unicode scientific notation
- `humanizeEngineeringNotation(double value, {int? precision})` - Engineering notation
- `humanizePhysicalConstant(String constant)` - Physical constants with proper formatting

#### Chemistry & Physics
- `humanizeChemicalFormula(String formula)` - Chemical formulas with subscripts
- `humanizeMathExpression(String expression)` - Math expressions with super/subscripts
- `humanizeWavelength(double meters)` - Wavelength with appropriate units
- `humanizeFrequency(double hertz)` - Frequency with appropriate units

#### Physical Units
- `humanizeEnergy(double joules, {EnergyUnit? unit})` - Energy formatting
- `humanizePower(double watts, {PowerUnit? unit})` - Power formatting
- `humanizeVoltage(double volts)` - Voltage formatting
- `humanizeCurrent(double amperes)` - Current formatting
- `humanizeResistance(double ohms)` - Resistance formatting
- `humanizeCapacitance(double farads)` - Capacitance formatting
- `humanizeTemperature(double kelvin, {TemperatureUnit? unit})` - Temperature formatting
- `humanizePressure(double pascals, {PressureUnit? unit})` - Pressure formatting

### Data Structure Functions

#### Structured Data
- `humanizeJSON(dynamic data, {int? indent, bool sortKeys = false})` - Pretty JSON formatting
- `humanizeXML(String xml, {int? indent})` - Pretty XML formatting
- `humanizeCSV(List<List<String>> data, {String delimiter = ','})` - CSV formatting

#### Tables & Lists
- `humanizeTable(List<List<String>> data, {TableStyle? style, bool showIndex = false})`
- `humanizeListStructure(List<dynamic> list, {ListStyle? style, bool allowNesting = true})`
- `humanizeKeyValuePairs(Map<String, dynamic> data, {String separator = ': '})`

#### Trees & Hierarchies
- `humanizeTree(Map<String, dynamic> tree, {TreeStyle? style})` - Visual tree structures
- `humanizeHierarchy(Map<String, dynamic> hierarchy, {int maxDepth = 5})`
- `humanizeMatrix(List<List<dynamic>> matrix, {MatrixStyle? style})`

### Enums & Configuration

#### Standards & Units
- `FileSizeStandard`: `si`, `iec`
- `DistanceUnit`: `meters`, `kilometers`, `feet`, `miles`, `nauticalMiles`
- `AreaUnit`: `squareMeters`, `squareKilometers`, `squareFeet`, `acres`
- `TemperatureUnit`: `kelvin`, `celsius`, `fahrenheit`
- `PressureUnit`: `pascals`, `kilopascals`, `atmospheres`, `bars`

#### Styles & Formats
- `DurationStyle`: `short`, `long`, `compact`
- `FriendlyDateStyle`: `friendly`, `relative`
- `ListStyle`: `bullet`, `numbered`, `dash`
- `TableStyle`: `ascii`, `unicode`, `minimal`
- `TreeStyle`: `unicode`, `ascii`

### Builder API

Use the `HumanFormatter` class for a fluent API:

```dart
final formatted = HumanFormatter()
  ..locale('es')
  ..decimalPlaces(2)
  .humanizeFileSize(1572864);
```

## Localization

The package includes built-in support for English (default) and Spanish. To add support for additional languages, you can implement the `HumanReadableLocalizations` interface.

## Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
