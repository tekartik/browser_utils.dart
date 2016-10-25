@TestOn("!vm")
import 'package:tekartik_browser_utils/css_utils.dart';
import 'package:test/test.dart';
import 'dart:html';

main() {
  group('css', () {
    test('loadCss', () async {
      // <link type="text/css" href="data/simple_stylesheet.css" rel="stylesheet">
      expect(
          document.head
              .querySelector('link[href="data/simple_stylesheet.css"]'),
          isNull);
      await loadStylesheet("data/simple_stylesheet.css");
      expect(
          document.head
              .querySelector('link[href="data/simple_stylesheet.css"]'),
          isNotNull);
    });
  });
}
