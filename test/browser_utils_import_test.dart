@TestOn('browser')

library js_utils_browser_test.dart;

import 'package:dev_test/test.dart';
import 'package:tekartik_browser_utils/browser_utils_import.dart';

// make we need no other import
void main() {
  setUpAll(() {
    //loadJavascriptScript('js_utils_browser_test.js');
  });

  /*
  group('browser_utils_import', () {
    expect(true, isTrue);
  });
  */

  group('Import', () {
    test('css', () async {
      await loadStylesheet('data/simple_stylesheet.css');
      await expectLater(() async {
        await loadStylesheet('data/simple_stylesheet_not_found.css');
      }, throwsA(isNot(isA<TestFailure>())));
    });
    test('js', () async {
      await loadJavascriptScript('data/simple_script.js');
      await expectLater(() async {
        await loadStylesheet('data/simple_script_not_found.js');
      }, throwsA(isNot(isA<TestFailure>())));
    });
  });
}
