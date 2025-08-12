import 'package:human_readable_formats/src/list.dart';
import 'package:test/test.dart';

void main() {
  group('humanizeList', () {
    test('formats empty list', () {
      expect(humanizeList([]), '');
    });

    test('formats single item list', () {
      expect(humanizeList(['apple']), 'apple');
    });

    test('formats two item list', () {
      expect(humanizeList(['apple', 'banana']), 'apple and banana');
    });

    test('formats three item list with oxford comma', () {
      expect(humanizeList(['apple', 'banana', 'orange']), 'apple, banana, and orange');
    });

    test('formats three item list without oxford comma', () {
      expect(humanizeList(['apple', 'banana', 'orange'], oxfordComma: false), 'apple, banana and orange');
    });

    test('formats four item list with oxford comma', () {
      expect(humanizeList(['apple', 'banana', 'orange', 'grape']), 'apple, banana, orange, and grape');
    });

    test('formats four item list without oxford comma', () {
      expect(humanizeList(['apple', 'banana', 'orange', 'grape'], oxfordComma: false), 'apple, banana, orange and grape');
    });

    test('formats with custom conjunction', () {
      expect(humanizeList(['red', 'blue'], conjunction: 'or'), 'red or blue');
      expect(humanizeList(['red', 'blue', 'green'], conjunction: 'or'), 'red, blue, or green');
    });

    test('formats with custom conjunction and no oxford comma', () {
      expect(humanizeList(['red', 'blue', 'green'], conjunction: 'or', oxfordComma: false), 'red, blue or green');
    });

    test('formats long list', () {
      final items = ['one', 'two', 'three', 'four', 'five'];
      expect(humanizeList(items), 'one, two, three, four, and five');
    });

    test('formats with numbers as strings', () {
      expect(humanizeList(['1', '2', '3']), '1, 2, and 3');
    });

    test('formats with mixed content', () {
      expect(humanizeList(['first item', 'second item', 'third item']), 'first item, second item, and third item');
    });
  });
}