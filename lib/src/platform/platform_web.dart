import 'dart:html';

void requestFullScreen() {
  document.documentElement!.requestFullscreen();
}

void exitFullScreen() {
  document.exitFullscreen();
}

bool isFullScreen() {
  return document.fullscreenElement != null;
}
