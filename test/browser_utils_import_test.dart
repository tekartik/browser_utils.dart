@TestOn('browser && !wasm')

library;

// ignore: deprecated_member_use_from_same_package
import 'package:tekartik_browser_utils/browser_utils_import.dart';
import 'package:test/test.dart';

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
