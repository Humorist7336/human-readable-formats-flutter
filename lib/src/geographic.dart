import 'dart:math' as math;

/// Geographic and location formatting utilities.

/// Formats coordinates in decimal degrees.
String humanizeCoordinates(double latitude, double longitude, {int precision = 6}) {
  final latStr = latitude.toStringAsFixed(precision);
  final lonStr = longitude.toStringAsFixed(precision);
  final latDir = latitude >= 0 ? 'N' : 'S';
  final lonDir = longitude >= 0 ? 'E' : 'W';
  
  return '${latStr.replaceFirst('-', '')}°$latDir, ${lonStr.replaceFirst('-', '')}°$lonDir';
}

/// Formats coordinates in degrees, minutes, seconds (DMS).
String humanizeCoordinatesDMS(double latitude, double longitude) {
  String formatDMS(double coordinate, String positiveDir, String negativeDir) {
    final isNegative = coordinate < 0;
    final absCoordinate = coordinate.abs();
    
    final degrees = absCoordinate.floor();
    final minutesDecimal = (absCoordinate - degrees) * 60;
    final minutes = minutesDecimal.floor();
    final seconds = (minutesDecimal - minutes) * 60;
    
    final direction = isNegative ? negativeDir : positiveDir;
    
    return '${degrees}°${minutes}\'${seconds.toStringAsFixed(2)}"$direction';
  }
  
  final latStr = formatDMS(latitude, 'N', 'S');
  final lonStr = formatDMS(longitude, 'E', 'W');
  
  return '$latStr, $lonStr';
}

/// Calculates and formats distance between two coordinates.
String humanizeDistance(double lat1, double lon1, double lat2, double lon2, {bool metric = true}) {
  // Haversine formula
  const earthRadius = 6371; // km
  
  final dLat = _degreesToRadians(lat2 - lat1);
  final dLon = _degreesToRadians(lon2 - lon1);
  
  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_degreesToRadians(lat1)) * math.cos(_degreesToRadians(lat2)) *
      math.sin(dLon / 2) * math.sin(dLon / 2);
  
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  final distanceKm = earthRadius * c;
  
  if (metric) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).toStringAsFixed(0)}m';
    } else if (distanceKm < 10) {
      return '${distanceKm.toStringAsFixed(2)}km';
    } else {
      return '${distanceKm.toStringAsFixed(1)}km';
    }
  } else {
    final distanceMiles = distanceKm * 0.621371;
    if (distanceMiles < 1) {
      final feet = distanceMiles * 5280;
      return '${feet.toStringAsFixed(0)}ft';
    } else if (distanceMiles < 10) {
      return '${distanceMiles.toStringAsFixed(2)}mi';
    } else {
      return '${distanceMiles.toStringAsFixed(1)}mi';
    }
  }
}

/// Formats elevation/altitude.
String humanizeElevation(double meters, {bool metric = true}) {
  if (metric) {
    if (meters.abs() < 10000) {
      return '${meters.toStringAsFixed(0)}m';
    } else {
      return '${(meters / 1000).toStringAsFixed(1)}km';
    }
  } else {
    final feet = meters * 3.28084;
    if (feet.abs() <= 5280) {
      if (meters.abs() >= 1609) { // 1 mile = 1609 meters
        return '${(feet / 5280).toStringAsFixed(1)}mi';
      } else {
        return '${feet.toStringAsFixed(0)}ft';
      }
    } else {
      return '${(feet / 5280).toStringAsFixed(1)}mi';
    }
  }
}

/// Formats area in human-readable units.
String humanizeArea(double squareMeters, {bool metric = true}) {
  if (metric) {
    if (squareMeters < 1) {
      return '${(squareMeters * 10000).toStringAsFixed(0)}cm²';
    } else if (squareMeters < 10000) {
      return '${squareMeters.toStringAsFixed(1)}m²';
    } else if (squareMeters < 1000000) {
      return '${(squareMeters / 10000).toStringAsFixed(1)}ha';
    } else {
      return '${(squareMeters / 1000000).toStringAsFixed(1)}km²';
    }
  } else {
    final squareFeet = squareMeters * 10.7639;
    if (squareFeet < 43560) {
      return '${squareFeet.toStringAsFixed(0)}ft²';
    } else {
      final acres = squareFeet / 43560;
      if (acres < 640) {
        return '${acres.toStringAsFixed(1)} acres';
      } else {
        return '${(acres / 640).toStringAsFixed(1)}mi²';
      }
    }
  }
}

/// Formats speed in various units.
String humanizeSpeed(double metersPerSecond, {bool metric = true}) {
  if (metric) {
    final kmh = metersPerSecond * 3.6;
    return '${kmh.toStringAsFixed(1)}km/h';
  } else {
    final mph = metersPerSecond * 2.23694;
    return '${mph.toStringAsFixed(1)}mph';
  }
}

/// Formats bearing/direction.
String humanizeBearing(double degrees) {
  const directions = [
    'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE',
    'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW'
  ];
  
  final normalizedDegrees = degrees % 360;
  final index = ((normalizedDegrees + 11.25) / 22.5).floor() % 16;
  
  return '${normalizedDegrees.toStringAsFixed(1)}° (${directions[index]})';
}

/// Formats timezone from coordinates (simplified).
String humanizeTimezoneFromCoordinates(double longitude) {
  // Simplified timezone calculation (not accounting for DST or political boundaries)
  final offsetHours = (longitude / 15).round();
  final sign = offsetHours >= 0 ? '+' : '-';
  final absOffset = offsetHours.abs();
  
  return 'UTC$sign${absOffset.toString().padLeft(2, '0')}:00';
}

/// Formats magnetic declination.
String humanizeMagneticDeclination(double declination) {
  final direction = declination >= 0 ? 'E' : 'W';
  return '${declination.abs().toStringAsFixed(1)}°$direction';
}

/// Formats GPS accuracy.
String humanizeGPSAccuracy(double accuracyMeters) {
  if (accuracyMeters < 1) {
    return '${(accuracyMeters * 100).toStringAsFixed(0)}cm';
  } else if (accuracyMeters < 1000) {
    return '${accuracyMeters.toStringAsFixed(1)}m';
  } else {
    return '${(accuracyMeters / 1000).toStringAsFixed(1)}km';
  }
}

/// Formats address components.
String humanizeAddress({
  String? street,
  String? city,
  String? state,
  String? postalCode,
  String? country,
}) {
  final components = <String>[];
  
  if (street != null && street.isNotEmpty) components.add(street);
  if (city != null && city.isNotEmpty) components.add(city);
  if (state != null && state.isNotEmpty) components.add(state);
  if (postalCode != null && postalCode.isNotEmpty) components.add(postalCode);
  if (country != null && country.isNotEmpty) components.add(country);
  
  return components.join(', ');
}

/// Formats geographic bounding box.
String humanizeBoundingBox(double north, double south, double east, double west) {
  return 'N:${north.toStringAsFixed(4)}, S:${south.toStringAsFixed(4)}, '
         'E:${east.toStringAsFixed(4)}, W:${west.toStringAsFixed(4)}';
}

/// Formats map scale.
String humanizeMapScale(double scale) {
  if (scale >= 1000000) {
    return '1:${(scale / 1000000).toStringAsFixed(1)}M';
  } else if (scale >= 1000) {
    return '1:${(scale / 1000).toStringAsFixed(1)}K';
  } else {
    return '1:${scale.toStringAsFixed(0)}';
  }
}

/// Formats UTM coordinates.
String humanizeUTM(int zone, String band, double easting, double northing) {
  return '${zone}${band} ${easting.toStringAsFixed(0)}E ${northing.toStringAsFixed(0)}N';
}

/// Formats what3words-style location (placeholder).
String humanizeWhat3Words(String word1, String word2, String word3) {
  return '///$word1.$word2.$word3';
}

/// Helper function to convert degrees to radians.
double _degreesToRadians(double degrees) {
  return degrees * (math.pi / 180);
}

/// Formats geographic region.
String humanizeRegion(String continent, String country, {String? state, String? city}) {
  final parts = <String>[continent, country];
  if (state != null) parts.add(state);
  if (city != null) parts.add(city);
  return parts.join(' > ');
}

/// Formats population density.
String humanizePopulationDensity(int population, double areaKm2) {
  final density = population / areaKm2;
  return '${density.toStringAsFixed(1)} people/km²';
}

/// Formats geographic feature type.
String humanizeGeographicFeature(String type, String name, {double? elevation}) {
  final elevationStr = elevation != null ? ' (${humanizeElevation(elevation)})' : '';
  return '$type: $name$elevationStr';
}