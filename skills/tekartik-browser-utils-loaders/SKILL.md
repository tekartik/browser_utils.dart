---
name: tekartik-browser-utils-loaders
description: >-
  Use when a Dart web app has to inject a javascript file or a stylesheet into
  the page at runtime with tekartik_browser_utils: loadJavascriptScript,
  debugLoadJavascriptScript, JavascriptScriptLoader, loadStylesheet,
  StylesheetLoader, the js_loader_utils.dart / js_utils.dart / css_utils.dart
  imports, loading a script once before using its dart:js_interop bindings, and
  testing the loaders with @TestOn('browser').
---

# tekartik_browser_utils: runtime script and stylesheet loading (tekartik_browser_utils)

`tekartik_browser_utils` appends `<script>` and `<link rel="stylesheet">` tags
to `document.head` and gives you a `Future` that completes when the browser
fired `load`, or fails when it fired `error`. That is how third-party
javascript (jQuery, Bootstrap, a maps sdk) gets pulled in before the Dart code
that binds to it runs.

## Guidelines

* Dependency (git only, not on pub.dev; single-package repo, so no `path:`):
  ```yaml
  dependencies:
    tekartik_browser_utils:
      git:
        url: https://github.com/tekartik/browser_utils.dart
      version: '>=0.7.3'
  ```
* Imports:
  * `package:tekartik_browser_utils/js_loader_utils.dart` — `loadJavascriptScript`,
    `debugLoadJavascriptScript`, `JavascriptScriptLoader`. Nothing else.
  * `package:tekartik_browser_utils/js_utils.dart` — re-exports the above and
    adds `debugRunningAsJavascript` (`identical(1, 1.0)`, true when compiled to
    js, false on wasm and on the VM).
  * `package:tekartik_browser_utils/css_utils.dart` — `loadStylesheet`,
    `StylesheetLoader`.
  These libraries go through `package:web`, so they are for code compiled for
  the browser only: do not import them from code that also runs on the Dart VM
  or in a non-web Flutter target.
* `await loadJavascriptScript(src)` resolves once the script executed. `src` is
  whatever the page can serve: a relative path (`data/simple_script.js`), a
  `packages/<pkg>/...` path for a file shipped in another package's `lib/`, or a
  protocol-relative/absolute url. On a 404 or a parse error the future
  completes with `Exception('script $src not loaded')` — nothing is retried and
  the `<script>` tag stays in the head.
* `loadStylesheet(src)` is the css equivalent and fails with
  `Exception('stylesheet $src not loaded')`. It sets `type="text/css"` and
  `rel="stylesheet"`; css and js loads are independent, so start them together
  with `Future.wait` when order does not matter.
* Both futures complete only once: do not call the bare functions twice for the
  same url, you would inject a second tag. For "load on first use" semantics use
  the loader objects, which wrap `AsyncOnceRunner` from
  `package:tekartik_common_utils/async_utils.dart`:
  `JavascriptScriptLoader(src)` / `StylesheetLoader(src)`, then `await
  loader.load()` (alias of `run()`), and read `loader.loaded` (alias of `done`).
  Concurrent `load()` calls are serialized by a lock; a failed load rethrows and
  leaves `loaded` false, so the next `load()` tries again.
* Declare the loaders as top-level `final` so the once-only guarantee is
  process-wide; a loader created per call defeats the purpose.
* `debugLoadJavascriptScript(src)` is the same as `loadJavascriptScript` with
  `print` traces (`dbg_loading:`, `dbg_onLoad:`, `dbg_onError(...)`). Use it
  while diagnosing a load that never resolves, not in shipped code.
* Bind to the loaded script with `dart:js_interop` `external` members
  (`@JS('someGlobal')`), and only read them *after* the future resolved — the
  globals simply do not exist before that. `package:tekartik_js_utils_interop`
  (a dependency of this package) has `jsObjectKeys` and friends when you need to
  inspect an unknown object.
* Anti-patterns: assuming `onLoad`/`onError` are also delivered as `onDone`
  (they are not, the futures are the only signal); loading a script in a
  `setUp` that runs per test instead of `setUpAll` or a `JavascriptScriptLoader`;
  importing these libraries in shared multiplatform code (use
  `../tekartik-browser-utils-platform/SKILL.md` helpers, which have VM stubs).
* Tests live under `test/` with `@TestOn('browser')` and their fixtures under
  `test/data/`; run them with `dart test -p chrome`. Check the effect on the DOM
  through `package:web` (`web.document.head!.querySelector('link[href="..."]')`).

## Examples

### Load a third-party script, then call into it

```dart
import 'dart:js_interop';

import 'package:tekartik_browser_utils/js_loader_utils.dart';

@JS('myLib.greet')
external String greet(String name);

/// Loads the script once, then calls into it.
Future<String> greetFromJs(String name) async {
  await loadJavascriptScript('https://example.com/my_lib.js');
  // `greet` only exists once the future above resolved.
  return greet(name);
}
```

### Load css and js once, on first use

```dart
import 'package:tekartik_browser_utils/css_utils.dart';
import 'package:tekartik_browser_utils/js_loader_utils.dart';

final _mapsCssLoader = StylesheetLoader('packages/my_app/maps/maps.css');
final _mapsJsLoader = JavascriptScriptLoader('packages/my_app/maps/maps.js');

/// Safe to call from every widget/route that needs the maps sdk.
Future<void> ensureMapsLoaded() async {
  await _mapsCssLoader.load();
  await _mapsJsLoader.load();
  assert(_mapsJsLoader.loaded);
}
```

### Load an optional script without breaking the page

```dart
import 'package:tekartik_browser_utils/console_utils.dart';
import 'package:tekartik_browser_utils/js_loader_utils.dart';

/// Returns false when the script could not be fetched or failed to run.
Future<bool> tryLoadJavascriptScript(String src) async {
  try {
    await loadJavascriptScript(src);
    return true;
  } catch (e, st) {
    printError(e, st);
    return false;
  }
}
```

### Browser test for a loader

```dart
@TestOn('browser')
library;

import 'package:tekartik_browser_utils/css_utils.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

void main() {
  test('loadStylesheet appends a link to head', () async {
    const href = 'data/simple_stylesheet.css';
    expect(web.document.head!.querySelector('link[href="$href"]'), isNull);
    await loadStylesheet(href);
    expect(web.document.head!.querySelector('link[href="$href"]'), isNotNull);
  });

  test('a missing stylesheet fails', () async {
    var loader = StylesheetLoader('data/DOES_NOT_EXIST.css');
    await expectLater(loader.load(), throwsA(isA<Exception>()));
    expect(loader.loaded, isFalse);
  });
}
```
