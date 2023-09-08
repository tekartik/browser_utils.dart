import 'dart:html';
export 'package:tekartik_browser_utils/src/storage_utils.dart'
    show webSessionStorageGet, webSessionStorageRemove, webSessionStorageSet;

void requestFullScreen() {
  document.documentElement!.requestFullscreen();
}

void exitFullScreen() {
  document.exitFullscreen();
}

bool isFullScreen() {
  return document.fullscreenElement != null;
}
