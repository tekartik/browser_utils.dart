@TestOn("!vm")

//import 'package:tekartik_utils/dev_utils.dart';
import 'package:tekartik_browser_utils/browser_detect_utils.dart';
import 'package:test/test.dart';

void main() {
  group('browser_detect', () {
    _checkSingleBrowser() {
      if (isChrome) {
        expect(isIe || isFirefox || isSafari, isFalse);
      }
      if (isSafari) {
        expect(isIe || isFirefox || isChrome, isFalse);
      }
      if (isIe) {
        expect(isSafari || isFirefox || isChrome, isFalse);
      }
      if (isFirefox) {
        expect(isIe || isSafari || isChrome, isFalse);
      }
    }

    test('single_browser', () {
      _checkSingleBrowser();
    });
    test('one_browser', () {
      // But there should be at least one browser
      // TODO support opera...
      expect(isIe || isSafari || isChrome || isFirefox, isTrue);
    });

    test('chrome', () {
      expect(isChrome, isTrue);
    }, testOn: "chrome || dartium || content-shell");

    test('firefox', () {
      expect(isFirefox, isTrue);
    }, testOn: "firefox");

    test('ie', () {
      expect(isIe, isTrue);
    }, testOn: "ie");

    test('safari', () {
      expect(isSafari, isTrue);
    }, testOn: "safari");
  });
}
