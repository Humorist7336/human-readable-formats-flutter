import 'package:test/test.dart';
import 'package:human_readable_formats/src/geographic.dart';

void main() {
  group('humanizeCoordinates', () {
    test('formats positive coordinates', () {
      expect(humanizeCoordinates(40.7128, -74.0060), '40.712800°N, 74.006000°W');
      expect(humanizeCoordinates(51.5074, -0.1278), '51.507400°N, 0.127800°W');
    });

    test('formats negative coordinates', () {
      expect(humanizeCoordinates(-33.8688, 151.2093), '33.868800°S, 151.209300°E');
    });

    test('handles custom precision', () {
      expect(humanizeCoordinates(40.7128, -74.0060, precision: 2), '40.71°N, 74.01°W');
    });
  });

  group('humanizeCoordinatesDMS', () {
    test('formats coordinates in DMS format', () {
      final result = humanizeCoordinatesDMS(40.7128, -74.0060);
      expect(result, contains('40°'));
      expect(result, contains('74°'));
      expect(result, contains('N'));
      expect(result, contains('W'));
    });

    test('handles negative coordinates', () {
      final result = humanizeCoordinatesDMS(-33.8688, 151.2093);
      expect(result, contains('S'));
      expect(result, contains('E'));
    });
  });

  group('humanizeDistance', () {
    test('calculates distance between coordinates in metric', () {
      // Distance between NYC and LA (approximately 3944 km)
      final distance = humanizeDistance(40.7128, -74.0060, 34.0522, -118.2437);
      expect(distance, contains('km'));
      expect(distance, contains('3')); // Should be around 3944 km
    });

    test('calculates distance in imperial units', () {
      final distance = humanizeDistance(40.7128, -74.0060, 34.0522, -118.2437, metric: false);
      expect(distance, contains('mi'));
    });

    test('formats short distances in meters', () {
      // Very close coordinates
      final distance = humanizeDistance(40.7128, -74.0060, 40.7129, -74.0061);
      expect(distance, contains('m'));
    });
  });

  group('humanizeElevation', () {
    test('formats elevation in meters', () {
      expect(humanizeElevation(500), '500m');
      expect(humanizeElevation(1500), '1500m');
      expect(humanizeElevation(-100), '-100m');
    });

    test('formats elevation in feet', () {
      expect(humanizeElevation(500, metric: false), '1640ft');
      expect(humanizeElevation(1609, metric: false), '1.0mi'); // ~1 mile
    });
  });

  group('humanizeArea', () {
    test('formats area in metric units', () {
      expect(humanizeArea(0.5), '5000cm²');
      expect(humanizeArea(100), '100.0m²');
      expect(humanizeArea(50000), '5.0ha');
      expect(humanizeArea(2000000), '2.0km²');
    });

    test('formats area in imperial units', () {
      expect(humanizeArea(100, metric: false), '1076ft²');
      expect(humanizeArea(50000, metric: false), '12.4 acres');
    });
  });

  group('humanizeSpeed', () {
    test('formats speed in metric units', () {
      expect(humanizeSpeed(10), '36.0km/h');
      expect(humanizeSpeed(27.78), '100.0km/h'); // ~100 km/h
    });

    test('formats speed in imperial units', () {
      expect(humanizeSpeed(10, metric: false), '22.4mph');
      expect(humanizeSpeed(44.7, metric: false), '100.0mph'); // ~100 mph
    });
  });

  group('humanizeBearing', () {
    test('formats bearing with cardinal directions', () {
      expect(humanizeBearing(0), '0.0° (N)');
      expect(humanizeBearing(90), '90.0° (E)');
      expect(humanizeBearing(180), '180.0° (S)');
      expect(humanizeBearing(270), '270.0° (W)');
    });

    test('formats bearing with intermediate directions', () {
      expect(humanizeBearing(45), '45.0° (NE)');
      expect(humanizeBearing(135), '135.0° (SE)');
      expect(humanizeBearing(225), '225.0° (SW)');
      expect(humanizeBearing(315), '315.0° (NW)');
    });

    test('handles angles over 360 degrees', () {
      expect(humanizeBearing(450), '90.0° (E)'); // 450 % 360 = 90
    });
  });

  group('humanizeTimezoneFromCoordinates', () {
    test('calculates timezone from longitude', () {
      expect(humanizeTimezoneFromCoordinates(0), 'UTC+00:00'); // Greenwich
      expect(humanizeTimezoneFromCoordinates(75), 'UTC+05:00'); // India
      expect(humanizeTimezoneFromCoordinates(-75), 'UTC-05:00'); // US East Coast
    });
  });

  group('humanizeMagneticDeclination', () {
    test('formats magnetic declination', () {
      expect(humanizeMagneticDeclination(5.5), '5.5°E');
      expect(humanizeMagneticDeclination(-3.2), '3.2°W');
      expect(humanizeMagneticDeclination(0), '0.0°E');
    });
  });

  group('humanizeGPSAccuracy', () {
    test('formats GPS accuracy', () {
      expect(humanizeGPSAccuracy(0.5), '50cm');
      expect(humanizeGPSAccuracy(5), '5.0m');
      expect(humanizeGPSAccuracy(1500), '1.5km');
    });
  });

  group('humanizeAddress', () {
    test('formats complete address', () {
      final address = humanizeAddress(
        street: '123 Main St',
        city: 'New York',
        state: 'NY',
        postalCode: '10001',
        country: 'USA',
      );
      expect(address, '123 Main St, New York, NY, 10001, USA');
    });

    test('handles partial address', () {
      final address = humanizeAddress(
        city: 'New York',
        country: 'USA',
      );
      expect(address, 'New York, USA');
    });

    test('handles empty components', () {
      final address = humanizeAddress(
        street: '',
        city: 'New York',
        state: null,
      );
      expect(address, 'New York');
    });
  });

  group('humanizeBoundingBox', () {
    test('formats bounding box coordinates', () {
      final bbox = humanizeBoundingBox(40.8, 40.7, -73.9, -74.1);
      expect(bbox, 'N:40.8000, S:40.7000, E:-73.9000, W:-74.1000');
    });
  });

  group('humanizeMapScale', () {
    test('formats map scales', () {
      expect(humanizeMapScale(1000000), '1:1.0M');
      expect(humanizeMapScale(50000), '1:50.0K');
      expect(humanizeMapScale(500), '1:500');
    });
  });

  group('humanizeUTM', () {
    test('formats UTM coordinates', () {
      expect(humanizeUTM(18, 'T', 585628, 4511322), '18T 585628E 4511322N');
    });
  });

  group('humanizeWhat3Words', () {
    test('formats what3words location', () {
      expect(humanizeWhat3Words('filled', 'count', 'soap'), '///filled.count.soap');
    });
  });

  group('humanizeRegion', () {
    test('formats geographic region', () {
      expect(humanizeRegion('North America', 'USA'), 'North America > USA');
      expect(humanizeRegion('North America', 'USA', state: 'California'), 
             'North America > USA > California');
      expect(humanizeRegion('North America', 'USA', state: 'California', city: 'San Francisco'), 
             'North America > USA > California > San Francisco');
    });
  });

  group('humanizePopulationDensity', () {
    test('calculates population density', () {
      expect(humanizePopulationDensity(8000000, 778.2), '10280.1 people/km²'); // NYC approx
    });
  });

  group('humanizeGeographicFeature', () {
    test('formats geographic features', () {
      expect(humanizeGeographicFeature('Mountain', 'Mount Everest'), 'Mountain: Mount Everest');
      expect(humanizeGeographicFeature('Mountain', 'Mount Everest', elevation: 8848), 
             'Mountain: Mount Everest (8848m)');
    });
  });
}