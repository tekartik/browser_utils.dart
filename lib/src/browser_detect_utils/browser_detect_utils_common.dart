/**
 * exported for testing only
 */
library tekartik_browser_utils_common;

import 'package:tekartik_common_utils/version_utils.dart';

class BrowserDetectCommon {
// Handle stuff like 'Trident/7.0, Chrome/29.0...'
  bool _checkAndGetVersion(String name) {
    int index = _userAgent.indexOf(name);
    if (index >= 0) {
      String versionString = _userAgent.substring(index + name.length + 1);
      int endVersion = versionString.indexOf(' ');
      if (endVersion >= 0) {
        versionString = versionString.substring(0, endVersion);
      }
      endVersion = versionString.indexOf(';');
      if (endVersion >= 0) {
        versionString = versionString.substring(0, endVersion);
      }
      _browserVersion = parseVersion(versionString);
      return true;
    }
    return false;
  }

  Version _browserVersion;

  Version get browserVersion => _browserVersion;

  bool _isIe;
  bool get isIe {
    if (_isIe == null) {
      init();
      _isIe = _checkAndGetVersion('Trident');
    }
    return _isIe;
  }

  bool _isChrome;

  bool get isChrome {
    if (_isChrome == null) {
      init();
      // Can check vendor too...
      _isChrome = _checkAndGetVersion('Chrome');
    }
    return _isChrome;
  }

  bool get isChromeDartium {
    return isChrome && _userAgent.contains('(Dart)');
  }

  bool _isFirefox;
  bool get isFirefox {
    if (_isFirefox == null) {
      init();
      _isFirefox = _checkAndGetVersion('Firefox');
    }
    return _isFirefox;
  }

  bool _isSafari;
  bool get isSafari {
    if (_isSafari == null) {
      init();
      _isSafari = !isChrome && _userAgent.contains('Safari');
      if (_isSafari) {
        _checkAndGetVersion('Version');
      }
    }
    return _isSafari;
  }

// every browser can be mobile
  bool get isMobile {
    return false;
  }

  String _userAgent;

  String get userAgent => _userAgent;

  set userAgent(String userAgent_) {
    this._userAgent = userAgent_;
    _isFirefox = null;
    _isChrome = null;
    _isSafari = null;
    _isIe = null;
  }

  // To override
  init() {}
}
