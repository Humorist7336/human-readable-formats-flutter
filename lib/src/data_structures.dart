/// Advanced data structure formatting utilities.
import 'dart:convert';
import 'dart:math' as math;

/// Formats JSON data with proper indentation and syntax highlighting.
String humanizeJSON(dynamic data, {int indent = 2, bool colorize = false}) {
  final encoder = JsonEncoder.withIndent(' ' * indent);
  final jsonString = encoder.convert(data);
  
  if (!colorize) return jsonString;
  
  // Basic syntax highlighting with ANSI colors
  return jsonString
      .replaceAllMapped(RegExp(r'"([^"]+)":'), (match) => '\x1b[34m"${match.group(1)}":\x1b[0m') // Blue keys
      .replaceAllMapped(RegExp(r': "([^"]*)"'), (match) => ': \x1b[32m"${match.group(1)}"\x1b[0m') // Green strings
      .replaceAllMapped(RegExp(r': (\d+\.?\d*)'), (match) => ': \x1b[33m${match.group(1)}\x1b[0m') // Yellow numbers
      .replaceAllMapped(RegExp(r': (true|false|null)'), (match) => ': \x1b[35m${match.group(1)}\x1b[0m'); // Magenta literals
}

/// Formats XML data with proper indentation.
String humanizeXML(String xml, {int indent = 2}) {
  final buffer = StringBuffer();
  var level = 0;
  var inTag = false;
  var tagContent = StringBuffer();
  
  for (int i = 0; i < xml.length; i++) {
    final char = xml[i];
    
    if (char == '<') {
      if (tagContent.toString().trim().isNotEmpty) {
        buffer.writeln('${' ' * (level * indent)}${tagContent.toString().trim()}');
        tagContent.clear();
      }
      inTag = true;
      
      // Check if it's a closing tag
      if (i + 1 < xml.length && xml[i + 1] == '/') {
        level--;
      }
      
      buffer.write('${' ' * (level * indent)}<');
    } else if (char == '>') {
      buffer.write('>');
      inTag = false;
      
      // Check if it's a self-closing tag or opening tag
      if (xml[i - 1] != '/' && !xml.substring(xml.lastIndexOf('<', i), i + 1).contains('/')) {
        level++;
        buffer.writeln();
      } else if (xml[i - 1] == '/') {
        buffer.writeln();
      }
    } else if (inTag) {
      buffer.write(char);
    } else if (char.trim().isNotEmpty) {
      tagContent.write(char);
    }
  }
  
  return buffer.toString().trim();
}

/// Formats CSV data with proper alignment.
String humanizeCSV(List<List<String>> data, {String separator = ',', bool alignColumns = true}) {
  if (data.isEmpty) return '';
  
  if (!alignColumns) {
    return data.map((row) => row.join(separator)).join('\n');
  }
  
  // Calculate column widths
  final columnWidths = <int>[];
  for (final row in data) {
    for (int i = 0; i < row.length; i++) {
      if (i >= columnWidths.length) {
        columnWidths.add(0);
      }
      columnWidths[i] = math.max(columnWidths[i], row[i].length);
    }
  }
  
  // Format rows with padding
  final buffer = StringBuffer();
  for (final row in data) {
    final paddedRow = <String>[];
    for (int i = 0; i < row.length; i++) {
      final width = i < columnWidths.length ? columnWidths[i] : 0;
      paddedRow.add(row[i].padRight(width));
    }
    buffer.writeln(paddedRow.join(separator == ',' ? ', ' : separator));
  }
  
  return buffer.toString().trim();
}

/// Formats a table with headers and data.
String humanizeTable(List<String> headers, List<List<String>> rows, {
  String borderStyle = 'ascii',
  bool showIndex = false,
}) {
  if (headers.isEmpty && rows.isEmpty) return '';
  
  final allRows = <List<String>>[];
  if (headers.isNotEmpty) allRows.add(headers);
  allRows.addAll(rows);
  
  // Add index column if requested
  if (showIndex) {
    for (int i = 0; i < allRows.length; i++) {
      final indexValue = i == 0 && headers.isNotEmpty ? '#' : (i - (headers.isNotEmpty ? 1 : 0)).toString();
      allRows[i] = [indexValue, ...allRows[i]];
    }
  }
  
  // Calculate column widths
  final columnWidths = <int>[];
  for (final row in allRows) {
    for (int i = 0; i < row.length; i++) {
      if (i >= columnWidths.length) {
        columnWidths.add(0);
      }
      columnWidths[i] = math.max(columnWidths[i], row[i].length);
    }
  }
  
  final buffer = StringBuffer();
  
  // Border characters based on style
  final borders = _getBorderChars(borderStyle);
  
  // Top border
  buffer.writeln(_buildBorder(columnWidths, borders['top']!));
  
  // Headers
  if (headers.isNotEmpty) {
    buffer.writeln(_buildRow(allRows[0], columnWidths, borders['vertical']!['char']!));
    buffer.writeln(_buildBorder(columnWidths, borders['middle']!));
  }
  
  // Data rows
  final dataStartIndex = headers.isNotEmpty ? 1 : 0;
  for (int i = dataStartIndex; i < allRows.length; i++) {
    buffer.writeln(_buildRow(allRows[i], columnWidths, borders['vertical']!['char']!));
  }
  
  // Bottom border
  buffer.writeln(_buildBorder(columnWidths, borders['bottom']!));
  
  return buffer.toString().trim();
}

/// Formats a tree structure.
String humanizeTree(Map<String, dynamic> tree, {
  String indent = '  ',
  String branchChar = '├── ',
  String lastBranchChar = '└── ',
  String verticalChar = '│   ',
  String spaceChar = '    ',
}) {
  final buffer = StringBuffer();
  _buildTreeNode(tree, buffer, '', true, indent, branchChar, lastBranchChar, verticalChar, spaceChar);
  return buffer.toString().trim();
}

/// Formats a list as a hierarchical structure.
String humanizeHierarchy(List<Map<String, dynamic>> items, {
  String idKey = 'id',
  String parentKey = 'parent',
  String nameKey = 'name',
  String indent = '  ',
}) {
  final rootItems = items.where((item) => item[parentKey] == null).toList();
  final buffer = StringBuffer();
  
  for (final item in rootItems) {
    _buildHierarchyNode(item, items, buffer, 0, idKey, parentKey, nameKey, indent);
  }
  
  return buffer.toString().trim();
}

/// Formats key-value pairs with proper alignment.
String humanizeKeyValuePairs(Map<String, dynamic> data, {
  String separator = ': ',
  bool alignValues = true,
  int maxKeyWidth = 0,
}) {
  if (data.isEmpty) return '';
  
  final entries = data.entries.toList();
  final keyWidth = alignValues 
      ? math.max(maxKeyWidth, entries.map((e) => e.key.length).reduce(math.max))
      : 0;
  
  final buffer = StringBuffer();
  for (final entry in entries) {
    final key = alignValues ? entry.key.padRight(keyWidth) : entry.key;
    final value = _formatValue(entry.value);
    buffer.writeln('$key$separator$value');
  }
  
  return buffer.toString().trim();
}

/// Formats a list with bullets or numbers.
String humanizeListStructure(List<dynamic> items, {
  String style = 'bullet', // bullet, number, letter
  String indent = '  ',
  bool allowNesting = false,
}) {
  if (items.isEmpty) return '';
  
  final buffer = StringBuffer();
  
  for (int i = 0; i < items.length; i++) {
    final item = items[i];
    final marker = _getListMarker(style, i);
    
    if (item is List && allowNesting) {
      buffer.writeln('$marker ${item.first}');
      if (item.length > 1) {
        final subList = item.sublist(1);
        final subFormatted = humanizeListStructure(subList, style: style, indent: indent, allowNesting: allowNesting);
        final indentedSub = subFormatted.split('\n').map((line) => '$indent$line').join('\n');
        buffer.writeln(indentedSub);
      }
    } else {
      buffer.writeln('$marker ${_formatValue(item)}');
    }
  }
  
  return buffer.toString().trim();
}

/// Formats a matrix or 2D array.
String humanizeMatrix(List<List<dynamic>> matrix, {
  bool showIndices = false,
  String numberFormat = 'auto',
  int precision = 2,
}) {
  if (matrix.isEmpty) return '[]';
  
  final buffer = StringBuffer();
  final maxRows = matrix.length;
  final maxCols = matrix.isNotEmpty ? matrix[0].length : 0;
  
  // Calculate column widths
  final columnWidths = List.filled(maxCols + (showIndices ? 1 : 0), 0);
  
  if (showIndices) {
    columnWidths[0] = maxRows.toString().length + 2; // For row indices
  }
  
  for (int i = 0; i < maxRows; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      final colIndex = j + (showIndices ? 1 : 0);
      final value = _formatMatrixValue(matrix[i][j], numberFormat, precision);
      columnWidths[colIndex] = math.max(columnWidths[colIndex], value.length);
    }
  }
  
  // Format matrix
  buffer.writeln('[');
  for (int i = 0; i < maxRows; i++) {
    buffer.write('  [');
    
    if (showIndices) {
      buffer.write('${i.toString().padLeft(columnWidths[0] - 2)}: ');
    }
    
    for (int j = 0; j < matrix[i].length; j++) {
      final colIndex = j + (showIndices ? 1 : 0);
      final value = _formatMatrixValue(matrix[i][j], numberFormat, precision);
      buffer.write(value.padLeft(columnWidths[colIndex]));
      
      if (j < matrix[i].length - 1) buffer.write(', ');
    }
    
    buffer.write(']');
    if (i < maxRows - 1) buffer.write(',');
    buffer.writeln();
  }
  buffer.write(']');
  
  return buffer.toString();
}

// Helper functions

Map<String, Map<String, String>> _getBorderChars(String style) {
  switch (style.toLowerCase()) {
    case 'unicode':
    case 'box':
      return {
        'top': {'left': '┌', 'right': '┐', 'horizontal': '─', 'cross': '┬'},
        'middle': {'left': '├', 'right': '┤', 'horizontal': '─', 'cross': '┼'},
        'bottom': {'left': '└', 'right': '┘', 'horizontal': '─', 'cross': '┴'},
        'vertical': {'char': '│'},
      };
    case 'double':
      return {
        'top': {'left': '╔', 'right': '╗', 'horizontal': '═', 'cross': '╦'},
        'middle': {'left': '╠', 'right': '╣', 'horizontal': '═', 'cross': '╬'},
        'bottom': {'left': '╚', 'right': '╝', 'horizontal': '═', 'cross': '╩'},
        'vertical': {'char': '║'},
      };
    case 'ascii':
    default:
      return {
        'top': {'left': '+', 'right': '+', 'horizontal': '-', 'cross': '+'},
        'middle': {'left': '+', 'right': '+', 'horizontal': '-', 'cross': '+'},
        'bottom': {'left': '+', 'right': '+', 'horizontal': '-', 'cross': '+'},
        'vertical': {'char': '|'},
      };
  }
}

String _buildBorder(List<int> columnWidths, Map<String, String> chars) {
  final buffer = StringBuffer();
  buffer.write(chars['left']);
  
  for (int i = 0; i < columnWidths.length; i++) {
    buffer.write(chars['horizontal']! * (columnWidths[i] + 2));
    if (i < columnWidths.length - 1) {
      buffer.write(chars['cross']);
    }
  }
  
  buffer.write(chars['right']);
  return buffer.toString();
}

String _buildRow(List<String> row, List<int> columnWidths, String verticalChar) {
  final buffer = StringBuffer();
  buffer.write(verticalChar);
  
  for (int i = 0; i < row.length; i++) {
    final width = i < columnWidths.length ? columnWidths[i] : 0;
    buffer.write(' ${row[i].padRight(width)} ');
    if (i < row.length - 1) {
      buffer.write(verticalChar);
    }
  }
  
  buffer.write(verticalChar);
  return buffer.toString();
}

void _buildTreeNode(
  dynamic node,
  StringBuffer buffer,
  String prefix,
  bool isLast,
  String indent,
  String branchChar,
  String lastBranchChar,
  String verticalChar,
  String spaceChar,
) {
  if (node is Map<String, dynamic>) {
    final entries = node.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final isLastEntry = i == entries.length - 1;
      final marker = isLastEntry ? lastBranchChar : branchChar;
      
      buffer.writeln('$prefix$marker${entry.key}');
      
      if (entry.value is Map || entry.value is List) {
        final newPrefix = prefix + (isLastEntry ? spaceChar : verticalChar);
        _buildTreeNode(entry.value, buffer, newPrefix, isLastEntry, indent, branchChar, lastBranchChar, verticalChar, spaceChar);
      }
    }
  } else if (node is List) {
    for (int i = 0; i < node.length; i++) {
      final item = node[i];
      final isLastEntry = i == node.length - 1;
      final marker = isLastEntry ? lastBranchChar : branchChar;
      
      if (item is Map || item is List) {
        buffer.writeln('$prefix$marker[$i]');
        final newPrefix = prefix + (isLastEntry ? spaceChar : verticalChar);
        _buildTreeNode(item, buffer, newPrefix, isLastEntry, indent, branchChar, lastBranchChar, verticalChar, spaceChar);
      } else {
        buffer.writeln('$prefix$marker[$i] ${_formatValue(item)}');
      }
    }
  }
}

void _buildHierarchyNode(
  Map<String, dynamic> item,
  List<Map<String, dynamic>> allItems,
  StringBuffer buffer,
  int level,
  String idKey,
  String parentKey,
  String nameKey,
  String indent,
) {
  buffer.writeln('${indent * level}${item[nameKey]}');
  
  final children = allItems.where((child) => child[parentKey] == item[idKey]).toList();
  for (final child in children) {
    _buildHierarchyNode(child, allItems, buffer, level + 1, idKey, parentKey, nameKey, indent);
  }
}

String _getListMarker(String style, int index) {
  switch (style.toLowerCase()) {
    case 'number':
      return '${index + 1}.';
    case 'letter':
      final letter = String.fromCharCode(97 + (index % 26)); // a, b, c, ...
      return '$letter.';
    case 'bullet':
    default:
      return '•';
  }
}

String _formatValue(dynamic value) {
  if (value == null) return 'null';
  if (value is String) return value;
  if (value is num) return value.toString();
  if (value is bool) return value.toString();
  if (value is List) return '[${value.length} items]';
  if (value is Map) return '{${value.length} entries}';
  return value.toString();
}

String _formatMatrixValue(dynamic value, String format, int precision) {
  if (value is num) {
    switch (format.toLowerCase()) {
      case 'fixed':
        return value.toStringAsFixed(precision);
      case 'scientific':
        return value.toStringAsExponential(precision);
      case 'auto':
      default:
        if (value is int) return value.toString();
        return value.toStringAsFixed(precision);
    }
  }
  return value.toString();
}