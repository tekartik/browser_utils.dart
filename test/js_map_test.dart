@TestOn("browser")
library tekartik_browser_utils.test.js_map_test;

import 'package:dev_test/test.dart';
import 'package:tekartik_browser_utils/js_utils.dart';

main() {
  setUpAll(() {
    loadJavascriptScript('js_utils_browser_test.js');
  });
  /*
  group('js_map', () {
    test('simple', () {
      var jsObject = jsify({"test": "value"});
      JsMap jsMap = new JsMap(jsObject);
      print(jsMap);
    });
  });
  */
}
