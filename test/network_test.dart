import 'package:test/test.dart';
import 'package:human_readable_formats/src/network.dart';

void main() {
  group('humanizeBandwidth', () {
    test('formats bandwidth in decimal units', () {
      expect(humanizeBandwidth(1000), '1.0 Kbps');
      expect(humanizeBandwidth(1500000), '1.5 Mbps');
      expect(humanizeBandwidth(1000000000), '1.0 Gbps');
    });

    test('formats bandwidth in binary units', () {
      expect(humanizeBandwidth(1024, binary: true), '1.0 Kibps');
      expect(humanizeBandwidth(1536000, binary: true), '1.5 Mibps');
    });

    test('handles small values', () {
      expect(humanizeBandwidth(500), '500 bps');
      expect(humanizeBandwidth(100), '100 bps');
    });
  });

  group('humanizeLatency', () {
    test('formats latency in different units', () {
      expect(humanizeLatency(0.5), '500μs');
      expect(humanizeLatency(50), '50ms');
      expect(humanizeLatency(1500), '1.5s');
    });

    test('handles edge cases', () {
      expect(humanizeLatency(0), '0μs');
      expect(humanizeLatency(1), '1ms');
      expect(humanizeLatency(1000), '1.0s');
    });
  });

  group('humanizeFrequency', () {
    test('formats frequency in different units', () {
      expect(humanizeFrequency(1000), '1.0 KHz');
      expect(humanizeFrequency(2400000), '2.4 MHz');
      expect(humanizeFrequency(5000000000), '5.0 GHz');
    });

    test('handles small frequencies', () {
      expect(humanizeFrequency(60), '60 Hz');
      expect(humanizeFrequency(440), '440 Hz');
    });
  });

  group('humanizeIPWithSubnet', () {
    test('formats IP with subnet mask', () {
      expect(humanizeIPWithSubnet('192.168.1.1', 24), '192.168.1.1/24');
      expect(humanizeIPWithSubnet('10.0.0.1', 8), '10.0.0.1/8');
    });
  });

  group('humanizeMACAddress', () {
    test('formats MAC address correctly', () {
      expect(humanizeMACAddress('001b44113ab7'), '00:1B:44:11:3A:B7');
      expect(humanizeMACAddress('00-1b-44-11-3a-b7'), '00:1B:44:11:3A:B7');
      expect(humanizeMACAddress('00:1b:44:11:3a:b7'), '00:1B:44:11:3A:B7');
    });

    test('throws error for invalid MAC address', () {
      expect(() => humanizeMACAddress('invalid'), throwsArgumentError);
      expect(() => humanizeMACAddress('00:1b:44'), throwsArgumentError);
    });
  });

  group('humanizePort', () {
    test('formats port numbers', () {
      expect(humanizePort(80), '80');
      expect(humanizePort(443, protocol: 'HTTPS'), '443/HTTPS');
      expect(humanizePort(22, protocol: 'SSH'), '22/SSH');
    });
  });

  group('humanizeHTTPStatus', () {
    test('formats common HTTP status codes', () {
      expect(humanizeHTTPStatus(200), '200 OK');
      expect(humanizeHTTPStatus(404), '404 Not Found');
      expect(humanizeHTTPStatus(500), '500 Internal Server Error');
    });

    test('handles unknown status codes', () {
      expect(humanizeHTTPStatus(999), '999 Unknown Status');
    });
  });

  group('humanizeURL', () {
    test('formats URLs correctly', () {
      expect(humanizeURL('https://example.com'), 'HTTPS://example.com');
      expect(humanizeURL('http://localhost:3000/api'), 'HTTP://localhost:3000/api');
      expect(humanizeURL('ftp://files.example.com/path'), 'FTP://files.example.com/path');
    });

    test('handles URLs with query and fragment', () {
      expect(humanizeURL('https://example.com/search?q=test#results'), 
             'HTTPS://example.com/search?q=test#results');
    });

    test('handles invalid URLs', () {
      expect(humanizeURL('not-a-url'), 'not-a-url');
    });
  });

  group('humanizeDataRate', () {
    test('formats data rate in decimal units', () {
      expect(humanizeDataRate(1000), '1.0 KB/s');
      expect(humanizeDataRate(1500000), '1.5 MB/s');
      expect(humanizeDataRate(1000000000), '1.0 GB/s');
    });

    test('formats data rate in binary units', () {
      expect(humanizeDataRate(1024, binary: true), '1.0 KiB/s');
      expect(humanizeDataRate(1536000, binary: true), '1.5 MiB/s');
    });
  });

  group('humanizeProtocolVersion', () {
    test('formats protocol versions', () {
      expect(humanizeProtocolVersion('HTTP', '1.1'), 'HTTP v1.1');
      expect(humanizeProtocolVersion('TLS', '1.3'), 'TLS v1.3');
    });
  });

  group('humanizeCertificateValidity', () {
    final now = DateTime(2023, 6, 15);
    
    test('formats future validity', () {
      final notBefore = DateTime(2023, 7, 1);
      final notAfter = DateTime(2024, 7, 1);
      expect(humanizeCertificateValidity(notBefore, notAfter, now: now), 
             'Valid in 16 days');
    });

    test('formats current validity', () {
      final notBefore = DateTime(2023, 1, 1);
      final notAfter = DateTime(2023, 7, 1);
      expect(humanizeCertificateValidity(notBefore, notAfter, now: now), 
             'Expires in 16 days');
    });

    test('formats expired certificate', () {
      final notBefore = DateTime(2022, 1, 1);
      final notAfter = DateTime(2023, 1, 1);
      expect(humanizeCertificateValidity(notBefore, notAfter, now: now), 
             'Expired 165 days ago');
    });

    test('formats long-term validity', () {
      final notBefore = DateTime(2023, 1, 1);
      final notAfter = DateTime(2024, 1, 1);
      expect(humanizeCertificateValidity(notBefore, notAfter, now: now), 
             'Valid for 200 days');
    });
  });

  group('humanizeDNSRecord', () {
    test('formats DNS records', () {
      expect(humanizeDNSRecord('A', '192.168.1.1'), 'A: 192.168.1.1');
      expect(humanizeDNSRecord('CNAME', 'example.com'), 'CNAME: example.com');
    });
  });

  group('humanizeNetworkInterface', () {
    test('formats network interface status', () {
      expect(humanizeNetworkInterface('eth0', true), 'eth0: UP');
      expect(humanizeNetworkInterface('wlan0', false), 'wlan0: DOWN');
      expect(humanizeNetworkInterface('eth0', true, ipAddress: '192.168.1.100'), 
             'eth0: UP (192.168.1.100)');
    });
  });

  group('humanizePacketLoss', () {
    test('formats packet loss', () {
      expect(humanizePacketLoss(0), 'No packet loss');
      expect(humanizePacketLoss(0.5), '0.50% packet loss');
      expect(humanizePacketLoss(2.5), '2.5% packet loss');
    });
  });

  group('humanizeSignalStrength', () {
    test('formats signal strength with quality', () {
      expect(humanizeSignalStrength(-45), '-45dBm (Excellent)');
      expect(humanizeSignalStrength(-55), '-55dBm (Good)');
      expect(humanizeSignalStrength(-65), '-65dBm (Fair)');
      expect(humanizeSignalStrength(-75), '-75dBm (Weak)');
      expect(humanizeSignalStrength(-85), '-85dBm (Very Weak)');
    });
  });

  group('humanizeWiFiChannel', () {
    test('formats WiFi channel information', () {
      expect(humanizeWiFiChannel(6, 2437), 'Channel 6 (2437MHz, 2.4GHz)');
      expect(humanizeWiFiChannel(36, 5180), 'Channel 36 (5180MHz, 5GHz)');
    });
  });

  group('humanizeSpeedTest', () {
    test('formats speed test results', () {
      final result = humanizeSpeedTest(
        downloadSpeed: 50000000,
        uploadSpeed: 10000000,
        ping: 25,
      );
      expect(result, 'Download: 50.0 MB/s, Upload: 10.0 MB/s, Ping: 25ms');
    });

    test('formats speed test results with binary units', () {
      final result = humanizeSpeedTest(
        downloadSpeed: 52428800,
        uploadSpeed: 10485760,
        ping: 25,
        binary: true,
      );
      expect(result, 'Download: 50.0 MiB/s, Upload: 10.0 MiB/s, Ping: 25ms');
    });
  });
}