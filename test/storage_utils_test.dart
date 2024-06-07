@TestOn('browser')
library;

import 'package:tekartik_browser_utils/storage_utils.dart';
import 'package:test/test.dart';

void main() {
  group('storage', () {
    test('sessionStorage', () {
      var key = 'tekartikBrowserUtilsSessionStorageTestKey';
      webSessionStorageRemove(key);
      expect(webSessionStorageGet(key), isNull);
      webSessionStorageSet(key, '');
      expect(webSessionStorageGet(key), '');
      webSessionStorageRemove(key);
      expect(webSessionStorageGet(key), isNull);
      webSessionStorageSet(key, 'a');
      expect(webSessionStorageGet(key), 'a');
      var text = List.generate(1024, (index) => 'a').join();
      webSessionStorageSet(key, text);
      expect(webSessionStorageGet(key), text);
    });

    test('localStorage', () {
      var key = 'tekartikBrowserUtilsLocalStorageTestKey';
      webLocalStorageRemove(key);
      expect(webLocalStorageGet(key), isNull);
      webLocalStorageSet(key, '');
      expect(webLocalStorageGet(key), '');
      webLocalStorageRemove(key);
      expect(webLocalStorageGet(key), isNull);
      webLocalStorageSet(key, 'a');
      expect(webLocalStorageGet(key), 'a');
      var text = List.generate(1024, (index) => 'a').join();
      webLocalStorageSet(key, text);
      expect(webLocalStorageGet(key), text);
    });
  });
}
