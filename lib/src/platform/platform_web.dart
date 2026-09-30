import 'dart:js_interop';
import 'dart:typed_data';

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

/// The element put full screen: `tekartik_full_screen_section` if the page
/// has one, the whole document otherwise.
web.Element get _fullscreenElement {
  return web.document.getElementById('tekartik_full_screen_section') ??
      web.document.documentElement!;
}

/// True when the browser allows full screen on this page
/// (`document.fullscreenEnabled`): false in an iframe without
/// `allowfullscreen` and in some embedded browsers.
bool isFullScreenSupported() => web.document.fullscreenEnabled;

/// Ask the browser for full screen on the `tekartik_full_screen_section`
/// element if any, the whole document otherwise.
///
/// Must be called from a user gesture: the returned future fails when the
/// browser refuses (no gesture, not [isFullScreenSupported]).
Future<void> requestFullScreen() async {
  await _fullscreenElement.requestFullscreen().toDart;
}

/// Leave full screen, no-op when not full screen (the browser rejects
/// `exitFullscreen` when nothing is full screen).
Future<void> exitFullScreen() async {
  if (isFullScreen()) {
    await web.document.exitFullscreen().toDart;
  }
}

/// True while the document is full screen (`document.fullscreenElement`).
bool isFullScreen() {
  return web.document.fullscreenElement != null;
}

const _fullScreenChangeEvent = web.EventStreamProvider<web.Event>(
  'fullscreenchange',
);

/// The new [isFullScreen] value each time the document enters or leaves full
/// screen, including when the user presses escape.
Stream<bool> get onFullScreenChange =>
    _fullScreenChangeEvent.forTarget(web.document).map((_) => isFullScreen());

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

/// Creates an object URL for the given [bytes] and [mimeType].
///
/// The returned URL should be revoked with [web.URL.revokeObjectURL] once
/// it is no longer needed.
String webBlobUrl({required Uint8List bytes, required String mimeType}) {
  var blob = web.Blob([bytes.toJS].toJS, web.BlobPropertyBag(type: mimeType));
  return web.URL.createObjectURL(blob);
}
