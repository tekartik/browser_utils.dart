void requestFullScreen() =>
    throw UnsupportedError('requestFullScreen web only');

void exitFullScreen() => throw UnsupportedError('exitFullScreen web only');

bool isFullScreen() => throw UnsupportedError('isFullScreen web only');

String? webSessionStorageGet(String key) =>
    throw UnsupportedError('webSessionStorageGet web only');

void webSessionStorageSet(String key, String value) =>
    throw UnsupportedError('webSessionStorageSet web only');

void webSessionStorageRemove(String key) =>
    throw UnsupportedError('webSessionStorageRemove web only');

String? webLocalStorageGet(String key) =>
    throw UnsupportedError('webLocalStorageGet web only');

void webLocalStorageSet(String key, String value) =>
    throw UnsupportedError('webLocalStorageSet web only');

void webLocalStorageRemove(String key) =>
    throw UnsupportedError('webLocalStorageRemove web only');

/// Navigator language.
String get webNavigatorLanguage =>
    throw UnsupportedError('webNavigatorLanguage web only');

void webOpenInNewTab(Uri uri) {
  throw UnsupportedError('webOpenInNewTab web only');
}

void webOpenInNewWindow(Uri uri, {int? width, int? height}) {
  throw UnsupportedError('webOpenInNewWindow web only');
}

void webOpenInSameTab(Uri uri) {
  throw UnsupportedError('webOpenInSameTab web only');
}
