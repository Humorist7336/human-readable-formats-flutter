/// Network and technical formatting utilities.

/// Formats bandwidth in human-readable format (e.g., 1.5 Mbps).
String humanizeBandwidth(num bitsPerSecond, {bool binary = false}) {
  const binaryUnits = ['bps', 'Kibps', 'Mibps', 'Gibps', 'Tibps'];
  const decimalUnits = ['bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
  
  final units = binary ? binaryUnits : decimalUnits;
  final divisor = binary ? 1024 : 1000;
  
  if (bitsPerSecond < divisor) {
    return '${bitsPerSecond.toStringAsFixed(0)} ${units[0]}';
  }
  
  var value = bitsPerSecond.toDouble();
  var unitIndex = 0;
  
  while (value >= divisor && unitIndex < units.length - 1) {
    value /= divisor;
    unitIndex++;
  }
  
  return '${value.toStringAsFixed(1)} ${units[unitIndex]}';
}

/// Formats latency/ping in human-readable format.
String humanizeLatency(num milliseconds) {
  if (milliseconds < 1) {
    return '${(milliseconds * 1000).toStringAsFixed(0)}μs';
  } else if (milliseconds < 1000) {
    return '${milliseconds.toStringAsFixed(0)}ms';
  } else {
    return '${(milliseconds / 1000).toStringAsFixed(1)}s';
  }
}

/// Formats frequency in human-readable format (e.g., 2.4 GHz).
String humanizeFrequency(num hertz) {
  const units = ['Hz', 'KHz', 'MHz', 'GHz', 'THz'];
  
  if (hertz < 1000) {
    return '${hertz.toStringAsFixed(0)} ${units[0]}';
  }
  
  var value = hertz.toDouble();
  var unitIndex = 0;
  
  while (value >= 1000 && unitIndex < units.length - 1) {
    value /= 1000;
    unitIndex++;
  }
  
  return '${value.toStringAsFixed(1)} ${units[unitIndex]}';
}

/// Formats IP address with subnet mask.
String humanizeIPWithSubnet(String ipAddress, int subnetMask) {
  return '$ipAddress/$subnetMask';
}

/// Formats MAC address in standard format.
String humanizeMACAddress(String macAddress) {
  // Remove any existing separators and convert to uppercase
  final cleaned = macAddress.replaceAll(RegExp(r'[:-]'), '').toUpperCase();
  
  if (cleaned.length != 12) {
    throw ArgumentError('Invalid MAC address length');
  }
  
  // Insert colons every 2 characters
  final formatted = StringBuffer();
  for (int i = 0; i < cleaned.length; i += 2) {
    if (i > 0) formatted.write(':');
    formatted.write(cleaned.substring(i, i + 2));
  }
  
  return formatted.toString();
}

/// Formats port number with protocol.
String humanizePort(int port, {String? protocol}) {
  final protocolStr = protocol != null ? '/$protocol' : '';
  return '$port$protocolStr';
}

/// Formats HTTP status code with description.
String humanizeHTTPStatus(int statusCode) {
  const statusMessages = {
    100: 'Continue',
    101: 'Switching Protocols',
    200: 'OK',
    201: 'Created',
    202: 'Accepted',
    204: 'No Content',
    301: 'Moved Permanently',
    302: 'Found',
    304: 'Not Modified',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    422: 'Unprocessable Entity',
    429: 'Too Many Requests',
    500: 'Internal Server Error',
    502: 'Bad Gateway',
    503: 'Service Unavailable',
    504: 'Gateway Timeout',
  };
  
  final message = statusMessages[statusCode] ?? 'Unknown Status';
  return '$statusCode $message';
}

/// Formats URL with protocol highlighting.
String humanizeURL(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null || uri.scheme.isEmpty) return url;
  
  final scheme = uri.scheme.toUpperCase();
  final host = uri.host;
  final port = uri.hasPort ? ':${uri.port}' : '';
  final path = uri.path.isEmpty ? '' : uri.path;
  final query = uri.query.isEmpty ? '' : '?${uri.query}';
  final fragment = uri.fragment.isEmpty ? '' : '#${uri.fragment}';
  
  return '$scheme://$host$port$path$query$fragment';
}

/// Formats data transfer rate.
String humanizeDataRate(num bytesPerSecond, {bool binary = false}) {
  const binaryUnits = ['B/s', 'KiB/s', 'MiB/s', 'GiB/s', 'TiB/s'];
  const decimalUnits = ['B/s', 'KB/s', 'MB/s', 'GB/s', 'TB/s'];
  
  final units = binary ? binaryUnits : decimalUnits;
  final divisor = binary ? 1024 : 1000;
  
  if (bytesPerSecond < divisor) {
    return '${bytesPerSecond.toStringAsFixed(0)} ${units[0]}';
  }
  
  var value = bytesPerSecond.toDouble();
  var unitIndex = 0;
  
  while (value >= divisor && unitIndex < units.length - 1) {
    value /= divisor;
    unitIndex++;
  }
  
  return '${value.toStringAsFixed(1)} ${units[unitIndex]}';
}

/// Formats network protocol version.
String humanizeProtocolVersion(String protocol, String version) {
  return '$protocol v$version';
}

/// Formats SSL/TLS certificate validity.
String humanizeCertificateValidity(DateTime notBefore, DateTime notAfter, {DateTime? now}) {
  now ??= DateTime.now();
  
  if (now.isBefore(notBefore)) {
    final daysUntilValid = notBefore.difference(now).inDays;
    return 'Valid in $daysUntilValid days';
  } else if (now.isAfter(notAfter)) {
    final daysExpired = now.difference(notAfter).inDays;
    return 'Expired $daysExpired days ago';
  } else {
    final daysUntilExpiry = notAfter.difference(now).inDays;
    if (daysUntilExpiry <= 30) {
      return 'Expires in $daysUntilExpiry days';
    } else {
      return 'Valid for $daysUntilExpiry days';
    }
  }
}

/// Formats DNS record type.
String humanizeDNSRecord(String type, String value) {
  return '$type: $value';
}

/// Formats network interface status.
String humanizeNetworkInterface(String name, bool isUp, {String? ipAddress}) {
  final status = isUp ? 'UP' : 'DOWN';
  final ip = ipAddress != null ? ' ($ipAddress)' : '';
  return '$name: $status$ip';
}

/// Formats packet loss percentage.
String humanizePacketLoss(double lossPercentage) {
  if (lossPercentage == 0) {
    return 'No packet loss';
  } else if (lossPercentage < 1) {
    return '${lossPercentage.toStringAsFixed(2)}% packet loss';
  } else {
    return '${lossPercentage.toStringAsFixed(1)}% packet loss';
  }
}

/// Formats signal strength (dBm).
String humanizeSignalStrength(int dbm) {
  String quality;
  if (dbm >= -50) {
    quality = 'Excellent';
  } else if (dbm >= -60) {
    quality = 'Good';
  } else if (dbm >= -70) {
    quality = 'Fair';
  } else if (dbm >= -80) {
    quality = 'Weak';
  } else {
    quality = 'Very Weak';
  }
  
  return '${dbm}dBm ($quality)';
}

/// Formats WiFi channel information.
String humanizeWiFiChannel(int channel, double frequency) {
  final band = frequency < 3000 ? '2.4GHz' : '5GHz';
  return 'Channel $channel (${frequency.toStringAsFixed(0)}MHz, $band)';
}

/// Formats network speed test results.
String humanizeSpeedTest({
  required num downloadSpeed,
  required num uploadSpeed,
  required num ping,
  bool binary = false,
}) {
  final download = humanizeDataRate(downloadSpeed, binary: binary);
  final upload = humanizeDataRate(uploadSpeed, binary: binary);
  final latency = humanizeLatency(ping);
  
  return 'Download: $download, Upload: $upload, Ping: $latency';
}