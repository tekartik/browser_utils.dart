import 'dart:html';

String? webSessionStorageGet(String key) {
  return window.sessionStorage[key];
}

void webSessionStorageSet(String key, String value) {
  window.sessionStorage[key] = value;
}

void webSessionStorageRemove(String key) {
  window.sessionStorage.remove(key);
}
