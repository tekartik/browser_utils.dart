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

extension on web.Element {
  external void requestFullScreen();
  external void exitFullscreen();
  external JSAny? get fullscreenElement;
}

void requestFullScreen() {
  web.document.documentElement!.requestFullScreen();
}

void exitFullScreen() {
  web.document.documentElement!.exitFullscreen();
}

bool isFullScreen() {
  return web.document.documentElement!.fullscreenElement != null;
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
