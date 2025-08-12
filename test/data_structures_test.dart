import 'package:test/test.dart';
import 'package:human_readable_formats/src/data_structures.dart';

void main() {
  group('humanizeJSON', () {
    test('formats simple JSON', () {
      final data = {'name': 'John', 'age': 30, 'active': true};
      final result = humanizeJSON(data);
      expect(result, contains('"name": "John"'));
      expect(result, contains('"age": 30'));
      expect(result, contains('"active": true'));
    });

    test('handles nested objects', () {
      final data = {
        'user': {'name': 'John', 'age': 30},
        'items': [1, 2, 3]
      };
      final result = humanizeJSON(data);
      expect(result, contains('{\n'));
      expect(result, contains('  "user": {'));
    });

    test('handles custom indentation', () {
      final data = {'key': 'value'};
      final result = humanizeJSON(data, indent: 4);
      expect(result, contains('    "key": "value"'));
    });
  });

  group('humanizeXML', () {
    test('formats simple XML', () {
      final xml = '<root><item>value</item></root>';
      final result = humanizeXML(xml);
      expect(result, contains('<root>'));
      expect(result, contains('  <item>'));
      expect(result, contains('    value'));
    });

    test('handles custom indentation', () {
      final xml = '<root><item>value</item></root>';
      final result = humanizeXML(xml, indent: 4);
      expect(result, contains('    <item>'));
    });
  });

  group('humanizeCSV', () {
    test('formats basic CSV', () {
      final data = [
        ['Name', 'Age', 'City'],
        ['John', '30', 'New York'],
        ['Jane', '25', 'Boston']
      ];
      final result = humanizeCSV(data);
      expect(result, contains('Name, Age, City'));
      expect(result, contains('John, 30 , New York'));
    });

    test('handles custom separator', () {
      final data = [
        ['A', 'B'],
        ['1', '2']
      ];
      final result = humanizeCSV(data, separator: '|');
      expect(result, contains('A|B'));
      expect(result, contains('1|2'));
    });

    test('handles unaligned columns', () {
      final data = [
        ['A', 'B'],
        ['1', '2']
      ];
      final result = humanizeCSV(data, alignColumns: false);
      expect(result, 'A,B\n1,2');
    });
  });

  group('humanizeTable', () {
    test('formats table with headers', () {
      final headers = ['Name', 'Age'];
      final rows = [
        ['John', '30'],
        ['Jane', '25']
      ];
      final result = humanizeTable(headers, rows);
      expect(result, contains('Name'));
      expect(result, contains('John'));
      expect(result, contains('+'));
      expect(result, contains('|'));
    });

    test('handles index column', () {
      final headers = ['Name'];
      final rows = [['John'], ['Jane']];
      final result = humanizeTable(headers, rows, showIndex: true);
      expect(result, contains('#'));
      expect(result, contains('0'));
      expect(result, contains('1'));
    });

    test('handles different border styles', () {
      final headers = ['A'];
      final rows = [['1']];
      final unicodeResult = humanizeTable(headers, rows, borderStyle: 'unicode');
      expect(unicodeResult, contains('┌'));
      expect(unicodeResult, contains('│'));
    });
  });

  group('humanizeTree', () {
    test('formats simple tree', () {
      final tree = {
        'root': {
          'child1': 'value1',
          'child2': {'grandchild': 'value2'}
        }
      };
      final result = humanizeTree(tree);
      expect(result, contains('└── root'));
      expect(result, contains('├── child1'));
      expect(result, contains('└── child2'));
    });
  });

  group('humanizeHierarchy', () {
    test('formats hierarchical data', () {
      final items = [
        {'id': 1, 'parent': null, 'name': 'Root'},
        {'id': 2, 'parent': 1, 'name': 'Child 1'},
        {'id': 3, 'parent': 1, 'name': 'Child 2'},
        {'id': 4, 'parent': 2, 'name': 'Grandchild'}
      ];
      final result = humanizeHierarchy(items);
      expect(result, contains('Root'));
      expect(result, contains('  Child 1'));
      expect(result, contains('    Grandchild'));
    });
  });

  group('humanizeKeyValuePairs', () {
    test('formats key-value pairs', () {
      final data = {'name': 'John', 'age': 30, 'active': true};
      final result = humanizeKeyValuePairs(data);
      expect(result, contains('name  : John'));
      expect(result, contains('age   : 30'));
      expect(result, contains('active: true'));
    });

    test('handles custom separator', () {
      final data = {'key': 'value'};
      final result = humanizeKeyValuePairs(data, separator: ' = ');
      expect(result, contains('key = value'));
    });

    test('handles unaligned values', () {
      final data = {'key': 'value'};
      final result = humanizeKeyValuePairs(data, alignValues: false);
      expect(result, 'key: value');
    });
  });

  group('humanizeListStructure', () {
    test('formats bullet list', () {
      final items = ['Item 1', 'Item 2', 'Item 3'];
      final result = humanizeListStructure(items);
      expect(result, contains('• Item 1'));
      expect(result, contains('• Item 2'));
      expect(result, contains('• Item 3'));
    });

    test('formats numbered list', () {
      final items = ['First', 'Second', 'Third'];
      final result = humanizeListStructure(items, style: 'number');
      expect(result, contains('1. First'));
      expect(result, contains('2. Second'));
      expect(result, contains('3. Third'));
    });

    test('formats lettered list', () {
      final items = ['Alpha', 'Beta'];
      final result = humanizeListStructure(items, style: 'letter');
      expect(result, contains('a. Alpha'));
      expect(result, contains('b. Beta'));
    });
  });

  group('humanizeMatrix', () {
    test('formats simple matrix', () {
      final matrix = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ];
      final result = humanizeMatrix(matrix);
      expect(result, contains('['));
      expect(result, contains('1, 2, 3'));
      expect(result, contains('4, 5, 6'));
      expect(result, contains('7, 8, 9'));
    });

    test('handles indices', () {
      final matrix = [
        [1, 2],
        [3, 4]
      ];
      final result = humanizeMatrix(matrix, showIndices: true);
      expect(result, contains('0:'));
      expect(result, contains('1:'));
    });

    test('handles different number formats', () {
      final matrix = [
        [1.23456, 2.34567]
      ];
      final fixedResult = humanizeMatrix(matrix, numberFormat: 'fixed', precision: 2);
      expect(fixedResult, contains('1.23'));
      expect(fixedResult, contains('2.35'));
    });

    test('handles empty matrix', () {
      final matrix = <List<dynamic>>[];
      final result = humanizeMatrix(matrix);
      expect(result, '[]');
    });
  });
}