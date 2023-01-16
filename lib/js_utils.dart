library tekartik_browser_utils_js_utils;

import 'dart:async';
import 'dart:html';

import 'package:tekartik_common_utils/async_utils.dart';

export 'package:tekartik_js_utils/js_utils.dart';

Future debugLoadJavascriptScript(String src) {
  final completer = Completer<void>();
  var script = ScriptElement();
  print('dbg_loading: $src');
  script.type = 'text/javascript';
  script.onError.listen((e) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    print('dbg_onError($e): $src');
    completer.completeError(Exception('script $src not loaded'));
  }, onError: (Object e, StackTrace st) {
    // never called
    print('onErrorError: $src');
    completer.completeError(e, st);
  }, onDone: () {
    // never called
    print('onErrorDone: $src');
  });
  script.onLoad.listen((_) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    print('dbg_onLoad: $src');
    completer.complete();
  }, onError: (Object e, StackTrace st) {
    // never called
    print('onError: $src');
    completer.completeError(e, st);
  }, onDone: () {
    // never called
    print('onDone: $src');
  });
  // ignore: unsafe_html
  script.src = src;
  document.head!.children.add(script);
  return completer.future;
}

/// Helper to load a javascript script only once
class JavascriptScriptLoader extends AsyncOnceRunner {
  JavascriptScriptLoader(String src) : super(() => loadJavascriptScript(src));

  bool get loaded => done;

  FutureOr load() => run();
}

Future loadJavascriptScript(String src) {
  final completer = Completer<void>();
  var script = ScriptElement();
  script.type = 'text/javascript';
  script.onError.listen((e) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.completeError(Exception('script $src not loaded'));
  });
  script.onLoad.listen((_) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.complete();
  });
  // ignore: unsafe_html
  script.src = src;
  document.head!.children.add(script);
  return completer.future;
}

bool get _runningAsJavascript => identical(1, 1.0);

@Deprecated('user common_utils')
bool get runningAsJavascript => _runningAsJavascript;

bool get debugRunningAsJavascript => _runningAsJavascript;
