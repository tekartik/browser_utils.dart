@TestOn('browser && !wasm')
library;

import 'package:tekartik_browser_utils/js_utils.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    loadJavascriptScript('js_utils_browser_test.js');
  });
  /*
  group('js_map', () {
    test('simple', () {
      var jsObject = jsify({'test': 'value'});
      JsMap jsMap = new JsMap(jsObject);
      print(jsMap);
    });
  });
  */
}
