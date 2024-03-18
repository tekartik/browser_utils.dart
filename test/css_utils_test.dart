@TestOn('browser')
library tekartik_browser_utils.test.css_utils_test;

import 'package:dev_test/test.dart';
import 'package:path/path.dart';
import 'package:tekartik_browser_utils/css_utils.dart';
import 'package:web/web.dart' as web;

void main() {
  group('css', () {
    test('loadCss', () async {
      // <link type="text/css" href="data/simple_stylesheet.css" rel="stylesheet">
      expect(
          web.document.head!
              .querySelector('link[href="data/simple_stylesheet.css"]'),
          isNull);
      await loadStylesheet('data/simple_stylesheet.css');
      expect(
          web.document.head!
              .querySelector('link[href="data/simple_stylesheet.css"]'),
          isNotNull);
    });

    test('stylesheetLoader', () async {
      final loader = StylesheetLoader(
          url.join('data', 'stylesheet_loader_stylesheet.css'));
      expect(
          web.document.head!.querySelector(
              'link[href="data/stylesheet_loader_stylesheet.css"]'),
          isNull);
      expect(loader.loaded, isFalse);
      await loader.load();
      expect(loader.loaded, isTrue);
      expect(
          web.document.head!.querySelector(
              'link[href="data/stylesheet_loader_stylesheet.css"]'),
          isNotNull);
      web.document.head!
          .querySelector('link[href="data/stylesheet_loader_stylesheet.css"]')!
          .remove();
      expect(
          web.document.head!.querySelector(
              'link[href="data/stylesheet_loader_stylesheet.css"]'),
          isNull);
      await loader.load();
      expect(
          web.document.head!.querySelector(
              'link[href="data/stylesheet_loader_stylesheet.css"]'),
          isNull);
    });

    test('stylesheetLoader fail', () async {
      final loader = StylesheetLoader(
          url.join('data', 'DUMMY_stylesheet_loader_stylesheet.css'));

      try {
        await loader.load();
      } catch (e) {
        print(e);
      }
      expect(loader.loaded, isFalse);
    });
  });
}
