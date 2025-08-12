# Changelog

## 1.0.0 - Major Release 🎉

### 🚀 Major New Features

#### Network & Technical Formatting
- **Network Data**: `humanizeBandwidth()`, `humanizeLatency()`, `humanizeDataRate()`, `humanizePacketLoss()`
- **Network Addresses**: `humanizeIPAddress()`, `humanizeMACAddress()`, `humanizeURL()`
- **Network Performance**: `humanizeSpeedTest()`, `humanizeSignalStrength()`, `humanizeWiFiChannel()`
- **Protocols**: `humanizeHTTPStatus()`, `humanizeNetworkProtocol()`, `humanizeDNSRecord()`

#### Geographic & Mapping
- **Coordinates**: `humanizeCoordinates()`, `humanizeCoordinatesDMS()`, `humanizeUTMCoordinates()`, `humanizeWhat3Words()`
- **Distances & Areas**: `humanizeDistance()`, `humanizeArea()`, `humanizeElevation()`
- **Navigation**: `humanizeBearing()`, `humanizeGPSAccuracy()`, `humanizeTimezone()`, `humanizeAddress()`
- **Regions**: `humanizeBoundingBox()`, `humanizeRegion()`, `humanizeMagneticDeclination()`

#### Scientific & Technical
- **Scientific Notation**: `humanizeScientificNotation()`, `humanizeEngineeringNotation()`, `humanizePhysicalConstant()`
- **Chemistry**: `humanizeChemicalFormula()` with proper subscripts (H₂O, C₆H₁₂O₆)
- **Physics**: `humanizeWavelength()`, `humanizeFrequency()`, `humanizeTemperature()`, `humanizePressure()`
- **Electrical**: `humanizeVoltage()`, `humanizeCurrent()`, `humanizeResistance()`, `humanizeCapacitance()`
- **Energy**: `humanizeEnergy()`, `humanizePower()` with smart unit conversion
- **Mathematics**: `humanizeMathExpression()` with superscripts and subscripts

#### Data Structures
- **Structured Data**: `humanizeJSON()`, `humanizeXML()`, `humanizeCSV()` with pretty formatting
- **Tables**: `humanizeTable()` with Unicode/ASCII borders and indexing
- **Trees**: `humanizeTree()`, `humanizeHierarchy()` with visual tree structures
- **Lists**: `humanizeListStructure()` with bullet/numbered styles
- **Matrices**: `humanizeMatrix()`, `humanizeKeyValuePairs()` for 2D data

### 🔧 Enhanced Core Features
- **Numbers**: Added `humanizeCompactNumber()` (1.2K, 3.4M), `humanizeOrdinal()` (1st, 2nd, 3rd)
- **Currencies**: Added `humanizeCurrency()` with proper symbols and localization
- **Advanced Configuration**: Extended global configuration with new standards and units

### 📊 Statistics
- **60+ formatting functions** across 8 major categories
- **308 comprehensive tests** with 100% coverage
- **Unicode support** for scientific notation, chemical formulas, and tree structures
- **Smart unit conversion** with automatic scaling
- **Robust error handling** for edge cases and invalid inputs

### 🌍 Expanded Localization
- Enhanced English and Spanish support
- Extended localization for new geographic and scientific terms
- Improved number formatting for different locales

### ⚡ Performance & Quality
- Optimized algorithms for large data structures
- Memory-efficient formatting for complex hierarchies
- Comprehensive edge case handling
- Type-safe implementations with proper null safety

## 0.1.0

### New Features
- Added file size formatting with support for SI and IEC standards
- Added duration formatting with short and long styles
- Added friendly date formatting (e.g., "Today", "Yesterday", "Tomorrow at 3:45 PM")
- Added percentage and ratio formatting
- Added comprehensive localization support (English and Spanish)
- Added global configuration system for default settings
- Added fluent builder API for method chaining
- Added extensive test coverage

### Breaking Changes
- Removed Flutter widget dependencies (now pure Dart)
- Changed file size formatting to use `FileSizeStandard` enum instead of boolean flags
- Updated default decimal places behavior to be more intuitive
- Moved global configuration access into function bodies to fix compile-time constant issues

### Improvements
- Improved documentation with comprehensive examples
- Added migration guide for users upgrading from v0.0.x
- Added code examples for all major features
- Improved type safety and error handling

## 0.0.1

* Initial release of the package.
