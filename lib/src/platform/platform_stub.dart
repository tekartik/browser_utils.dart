import 'dart:typed_data';

bool isFullScreenSupported() =>
    throw UnsupportedError('isFullScreenSupported web only');

Future<void> requestFullScreen() =>
    throw UnsupportedError('requestFullScreen web only');

Future<void> exitFullScreen() =>
    throw UnsupportedError('exitFullScreen web only');

bool isFullScreen() => throw UnsupportedError('isFullScreen web only');

Stream<bool> get onFullScreenChange =>
    throw UnsupportedError('onFullScreenChange web only');

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

void webReload({Uri? uri}) {
  throw UnsupportedError('webReload() web only');
}

String webBlobUrl({required Uint8List bytes, required String mimeType}) =>
    throw UnsupportedError('webBlobUrl web only');
