@TestOn('browser && !wasm')
library;

// ignore: deprecated_member_use
import 'dart:html';

// ignore: deprecated_member_use_from_same_package
import 'package:tekartik_browser_utils/element_utils.dart';
import 'package:test/test.dart';

void main() {
  group('element_utils', () {
    test('disabled', () {
      Element element = DivElement();
      expect(isDisabled(element), isFalse);
      expect(isEnabled(element), isTrue);
      setDisabled(element, true);
      expect(isDisabled(element), isTrue);
      expect(isEnabled(element), isFalse);
      setEnabled(element, true);
      expect(isDisabled(element), isFalse);
      expect(isEnabled(element), isTrue);
    });

    test('find', () {
      Element element = DivElement()
        ..id = 'test'
        ..classes = ['test'];
      expect(findFirstAncestorWithClass(element, 'test', true), element);
      expect(findFirstAncestorWithId(element, 'test', true), element);
      expect(findFirstAncestorWithClass(element, 'test'), isNull);
      expect(findFirstAncestorWithId(element, 'test'), isNull);

      Element child = DivElement()
        ..id = 'child'
        ..classes = ['child'];
      element.append(child);
      expect(findFirstAncestorWithClass(child, 'child', true), child);
      expect(findFirstAncestorWithId(child, 'child', true), child);
      expect(findFirstAncestorWithClass(child, 'test', true), element);
      expect(findFirstAncestorWithId(child, 'test', true), element);
      expect(findFirstAncestorWithClass(child, 'test'), element);
      expect(findFirstAncestorWithId(child, 'test'), element);
    });
  });
}
