---
name: tekartik-browser-utils-platform
description: >-
  Use when Dart code needs browser storage, navigation, full screen, the
  navigator language, a blob download url, the current url arguments or a print
  that also shows in the page, through tekartik_browser_utils:
  webLocalStorageGet/Set/Remove, webSessionStorageGet/Set/Remove,
  webOpenInNewTab, webOpenInNewWindow, webOpenInSameTab, webReload,
  requestFullScreen, exitFullScreen, isFullScreen, webNavigatorLanguage,
  webBlobUrl, locationInfo, LocationInfo, MockLocationInfo,
  locationSearchGetArguments, ArgumentsOption, universalPrint, printError, and
  the storage_utils.dart / window_utils.dart / full_screen_utils.dart /
  language_utils.dart / blob_utils.dart / location_info_utils.dart /
  universal_print.dart imports.
---

# tekartik_browser_utils: browser platform helpers (tekartik_browser_utils)

Small `web:`-prefixed wrappers over the browser APIs that Dart code keeps
needing: `localStorage`/`sessionStorage`, opening and reloading windows, full
screen, the navigator language and object urls. Most of them are exported
through a conditional `platform.dart`, so the import compiles everywhere and
only *calling* them off the web throws `UnsupportedError`.

## Guidelines

* Dependency (git only, not on pub.dev; single-package repo, so no `path:`):
  ```yaml
  dependencies:
    tekartik_browser_utils:
      git:
        url: https://github.com/tekartik/browser_utils.dart
      version: '>=0.7.3'
  ```
* One narrow import per topic — never import `src/platform/platform.dart`
  directly, use the public facade:
  * `storage_utils.dart` — `webLocalStorageGet/Set/Remove`,
    `webSessionStorageGet/Set/Remove` (all `String` keys and values, the getters
    return `String?`).
  * `window_utils.dart` — `webOpenInSameTab(Uri)`, `webOpenInNewTab(Uri)`,
    `webOpenInNewWindow(Uri, {int? width, int? height})`, `webReload({Uri? uri})`.
  * `full_screen_utils.dart` — `requestFullScreen()`, `exitFullScreen()`,
    `isFullScreen()`.
  * `language_utils.dart` — `webNavigatorLanguage` (getter, e.g. `'en-US'`).
  * `blob_utils.dart` — `webBlobUrl({required Uint8List bytes, required String
    mimeType})`.
  * `universal_print.dart` — `print` / `universalPrint`.
  * `location_info_utils.dart` + `arguments_option.dart` — `locationInfo`,
    `ArgumentsOption`.
  * `console_utils.dart` — `printError(Object? e, [StackTrace? st])`.
* Those six `platform.dart`-backed libraries are import-safe on the VM: the stub
  implementation throws `UnsupportedError('<name> web only')` on every call.
  Guard with `kDartIsWeb` from `package:tekartik_common_utils/env_utils.dart`
  (or catch `UnsupportedError`) in code shared with the VM — the package's own
  `test/multiplatform/` tests do exactly that.
* `location_info_utils.dart`, `console_utils.dart` and `universal_print.dart`'s
  web branch reach `package:web` unconditionally: only `universal_print.dart`
  has an io fallback. Treat `locationInfo` and `printError` as web-only.
* `locationInfo` is a lazily built `LocationInfo?` (always non-null in the
  browser) with `host`, `path` and `arguments` (the query string already split
  and percent-decoded, `?a&b=1` giving `{'a': '', 'b': '1'}`). Cast it to
  `BrowserLocationInfo` only if you need `toDebugMap()`; for tests build a
  `MockLocationInfo` or call `locationSearchGetArguments(search)` directly (both
  in `src/location_info_common_utils.dart`, and that one is pure Dart).
* `ArgumentsOption('verbose').has()` returns `true` for `?verbose`, `false` for
  `?no-verbose` and `null` when neither is present — so `?? false` (or `?? true`
  for an opt-out flag) for the default. It reads `locationInfo`, so it is
  web-only too.
* `universal_print.dart` does `export 'dart:core' hide print;` and replaces
  `print` with `universalPrint`: on the web it logs to the console *and* mirrors
  the last 100 lines into a `<pre id="output">` element (created on demand), on
  the VM it is the normal `print`. Importing it in a file is enough to
  redirect every `print` in that file; that is the right import for example
  pages and demos, not for library code.
* `webBlobUrl` returns a `blob:` url you own: call `web.URL.revokeObjectURL(url)`
  when done, or the bytes stay alive for the life of the document.
* `webOpenInNewWindow` passes `location=yes` plus the width/height you give; it
  is a popup, so it is subject to the popup blocker unless called synchronously
  from a user gesture. `webReload(uri: ...)` replaces the location and then
  reloads.
* `requestFullScreen()` targets the element with id `tekartik_full_screen_section`
  when the page has one, otherwise `document.documentElement`. Like every full
  screen API it only works from a user gesture.
* Deprecated, do not use in new code: `element_utils.dart` (`setDisabled`,
  `findFirstAncestorWithId`, `nullTreeSanitizer`, ...), `js_map.dart` (`JsMap`)
  and `browser_utils_import.dart` — they are built on `dart:html` /
  `package:js`, are not wasm compatible and are kept only for old apps. Use
  `package:web` directly instead.
* Script and stylesheet loading lives in a separate skill:
  `../tekartik-browser-utils-loaders/SKILL.md`.
* Tests: pure-Dart parts (`locationSearchGetArguments`, `MockLocationInfo`,
  `universalPrint`, the `UnsupportedError` stubs) run under plain `dart test`;
  anything touching the DOM needs `@TestOn('browser')` and `dart test -p chrome`.

## Examples

### Multiplatform storage, guarded by `kDartIsWeb`

```dart
import 'package:tekartik_browser_utils/storage_utils.dart';
import 'package:tekartik_common_utils/env_utils.dart';

/// Web only preference, silently ignored elsewhere.
class TokenStore {
  static const _key = 'auth_token';

  String? read() => kDartIsWeb ? webLocalStorageGet(_key) : null;

  void write(String token) {
    if (kDartIsWeb) {
      webLocalStorageSet(_key, token);
    }
  }

  void clear() {
    if (kDartIsWeb) {
      webLocalStorageRemove(_key);
    }
  }
}
```

### Navigation, reload and full screen

```dart
import 'package:tekartik_browser_utils/full_screen_utils.dart';
import 'package:tekartik_browser_utils/window_utils.dart';

void openDocumentation() {
  webOpenInNewTab(Uri.parse('https://github.com/tekartik/browser_utils.dart'));
}

void openHelpPopup() {
  webOpenInNewWindow(Uri.parse('help.html'), width: 520, height: 570);
}

/// Reloads the current page with an extra query argument.
void reloadWithArgument(String name, String value) {
  webReload(uri: Uri.base.replace(queryParameters: {name: value}));
}

/// Must be called from a click handler.
void toggleFullScreen() {
  if (isFullScreen()) {
    exitFullScreen();
  } else {
    requestFullScreen();
  }
}
```

### Offer bytes as a file download

```dart
import 'dart:typed_data';

import 'package:tekartik_browser_utils/blob_utils.dart';
import 'package:web/web.dart' as web;

void downloadBytes(
  Uint8List bytes,
  String filename, {
  String mimeType = 'application/octet-stream',
}) {
  var url = webBlobUrl(bytes: bytes, mimeType: mimeType);
  var anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = filename;
  web.document.body!.appendChild(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(url);
}
```

### Read the url arguments and the browser language

```dart
import 'package:tekartik_browser_utils/arguments_option.dart';
import 'package:tekartik_browser_utils/language_utils.dart';
import 'package:tekartik_browser_utils/location_info_utils.dart';

final _verboseOption = ArgumentsOption('verbose');

/// `?verbose` -> true, `?no-verbose` -> false, absent -> false.
bool get verbose => _verboseOption.has() ?? false;

/// e.g. `{'host': 'localhost:8080', 'path': '/index.html', 'lang': 'en-US'}`
Map<String, Object?> describeLocation() {
  var info = locationInfo!;
  return {
    'host': info.host,
    'path': info.path,
    'arguments': info.arguments,
    'lang': webNavigatorLanguage,
  };
}
```

### Parse a query string, and print to the page

```dart
import 'package:tekartik_browser_utils/src/location_info_common_utils.dart';
import 'package:tekartik_browser_utils/universal_print.dart';

void main() {
  // Pure Dart, no browser needed: works in a VM unit test too.
  var arguments = locationSearchGetArguments('?tata&log=info&tutu=1');
  // `print` here is universalPrint: console + the #output <pre> on the web.
  print('arguments: $arguments');
  universalPrint('log level: ${arguments['log']}');

  var mock = MockLocationInfo()
    ..host = 'localhost:8080'
    ..path = '/index.html'
    ..arguments = arguments;
  print('mock: ${mock.path} ${mock.arguments}');
}
```
