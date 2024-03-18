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

/// Navigator language.
String get webNavigatorLanguage =>
    throw UnsupportedError('webNavigatorLanguage web only');
