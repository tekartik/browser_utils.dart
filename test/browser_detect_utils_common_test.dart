//import 'package:tekartik_utils/dev_utils.dart';
import 'package:tekartik_browser_utils/src/browser_detect_utils/browser_detect_utils_common.dart';
import 'package:test/test.dart';
import 'package:pub_semver/pub_semver.dart';

void main() => defineTests();

void defineTests() {
  group('browser_detect', () {
    BrowserDetectCommon browserDetect = new BrowserDetectCommon();

    _checkSingleBrowser() {
      if (browserDetect.isChrome) {
        expect(
            browserDetect.isIe ||
                browserDetect.isFirefox ||
                browserDetect.isSafari,
            isFalse);
      }
      if (browserDetect.isSafari) {
        expect(
            browserDetect.isIe ||
                browserDetect.isFirefox ||
                browserDetect.isChrome,
            isFalse);
      }
      if (browserDetect.isIe) {
        expect(
            browserDetect.isSafari ||
                browserDetect.isFirefox ||
                browserDetect.isChrome,
            isFalse);
      }
      if (browserDetect.isFirefox) {
        expect(
            browserDetect.isIe ||
                browserDetect.isSafari ||
                browserDetect.isChrome,
            isFalse);
      }
    }
    tearDown(() {
      // Cleanup any change
      browserDetect.userAgent = null;
    });

    test('safari', () {
      browserDetect.userAgent =
          'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25';
      expect(browserDetect.isSafari, isTrue);
      expect(browserDetect.browserVersion, new Version(6, 0, 0));
      _checkSingleBrowser();
    });

    test('ie', () {
      browserDetect.userAgent =
          'Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; Touch; .NET4.0E; .NET4.0C; .NET CLR 3.5.30729; .NET CLR 2.0.50727; .NET CLR 3.0.30729; Tablet PC 2.0; MALNJS; rv:11.0) like Gecko';
      expect(browserDetect.isIe, isTrue);
      expect(browserDetect.browserVersion, new Version(7, 0, 0));
      _checkSingleBrowser();
    });

    test('firefox', () {
      browserDetect.userAgent =
          'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0';
      expect(browserDetect.isFirefox, isTrue);
      expect(browserDetect.browserVersion, new Version(29, 0, 0));
      _checkSingleBrowser();
    });

    test('chrome', () {
      browserDetect.userAgent =
          'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36';
      expect(browserDetect.isChrome, isTrue);
      expect(
          browserDetect.browserVersion, new Version(36, 0, 1985, build: '125'));
      _checkSingleBrowser();
    });

    test('chrome_dartium', () {
      browserDetect.userAgent =
          'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.0 (Dart) Safari/537.36';
      expect(browserDetect.isChrome, isTrue);
      expect(
          browserDetect.browserVersion, new Version(37, 0, 2062, build: '0'));
      _checkSingleBrowser();
    });
  });
}
