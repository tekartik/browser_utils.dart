import 'dart:js_interop';

import 'package:web/web.dart' as web;

export 'package:tekartik_browser_utils/src/storage_utils.dart'
    show webSessionStorageGet, webSessionStorageRemove, webSessionStorageSet;

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
