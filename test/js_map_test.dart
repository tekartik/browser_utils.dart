@TestOn('browser && !wasm')
library;

// ignore: depend_on_referenced_packages, deprecated_member_use
import 'package:js/js_util.dart';
// ignore: deprecated_member_use_from_same_package
import 'package:tekartik_browser_utils/js_map.dart';
import 'package:test/test.dart';

void main() {
  group('js_map', () {
    test('simple', () {
      var jsObject = jsify({'test': 'value'}) as Object;
      var jsMap = JsMap<String>(jsObject);
      expect(jsMap['test'], 'value');
      expect(jsMap.containsKey('test'), isTrue);
      expect(jsMap.containsKey('other'), isFalse);
      jsMap['other'] = 'value2';
      expect(getProperty<Object?>(jsObject, 'other'), 'value2');
      expect(jsMap.keys, ['test', 'other']);
    });
  });
}
