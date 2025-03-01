import 'package:web/web.dart' as web;

String? webSessionStorageGet(String key) {
  return web.window.sessionStorage.getItem(key);
}

void webSessionStorageSet(String key, String value) {
  web.window.sessionStorage.setItem(key, value);
}

void webSessionStorageRemove(String key) {
  web.window.sessionStorage.removeItem(key);
}

void webLocalStorageSet(String key, String value) =>
    web.window.localStorage.setItem(key, value);

String? webLocalStorageGet(String key) => web.window.localStorage.getItem(key);

/// Delete an env var
void webLocalStorageRemove(String key) {
  web.window.localStorage.removeItem(key);
}
