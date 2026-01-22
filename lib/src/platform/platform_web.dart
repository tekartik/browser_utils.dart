import 'dart:js_interop';

import 'package:tekartik_browser_utils/src/window_utils.dart';
import 'package:web/web.dart' as web;
export 'package:tekartik_browser_utils/src/storage_utils.dart'
    show
        webSessionStorageGet,
        webSessionStorageRemove,
        webSessionStorageSet,
        webLocalStorageGet,
        webLocalStorageRemove,
        webLocalStorageSet;

web.Element get _fullscreenElement {
  return web.document.getElementById('tekartik_full_screen_section') ??
      web.document.documentElement!;
}

Future<void> requestFullScreen() async {
  await _fullscreenElement.requestFullscreen().toDart;
}

void exitFullScreen() {
  web.document.exitFullscreen();
}

bool isFullScreen() {
  return web.document.fullscreenElement != null;
}

/// Navigator language.
String get webNavigatorLanguage => web.window.navigator.language;

void webOpenInNewTab(Uri uri) {
  openInNewTab(uri);
}

void webOpenInNewWindow(Uri uri, {int? width, int? height}) {
  openInNewWindow(uri, width: width, height: height);
}

void webOpenInSameTab(Uri uri) {
  openInSameTab(uri);
}

void webReload({Uri? uri}) {
  reload(uri: uri);
}
