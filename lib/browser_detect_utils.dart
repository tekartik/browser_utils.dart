library tekartik_browser_utils_browser_detect_utils;

import 'dart:html';
import 'src/browser_detect_utils/browser_detect_utils_common.dart';
export 'src/browser_detect_utils/browser_detect_utils_common.dart';

class BrowserDetect extends BrowserDetectCommon {
  @override
  init() {
    if (userAgent == null) {
      userAgent = window.navigator.userAgent;
    }
  }
}

BrowserDetect _browserDetect;

BrowserDetect get browserDetect {
  if (_browserDetect == null) {
    _browserDetect = new BrowserDetect();
  }
  return _browserDetect;
}

bool get isIe => browserDetect.isIe;
bool get isChrome => browserDetect.isChrome;
bool get isFirefox => browserDetect.isFirefox;
bool get isSafari => browserDetect.isSafari;
bool get isChromeDartium => browserDetect.isChromeDartium;
