// ignore_for_file: avoid_print

library;

import 'dart:async';

import 'package:tekartik_common_utils/async_utils.dart';
import 'package:web/web.dart' as web;

//export 'package:tekartik_js_utils/js_utils.dart';

Future<void> debugLoadJavascriptScript(String src) {
  final completer = Completer<void>();
  var script = web.HTMLScriptElement();
  print('dbg_loading: $src');
  script.type = 'text/javascript';
  script.onError.listen(
    (e) {
      // The only callback called upon failure
      print('dbg_onError($e): $src');
      completer.completeError(Exception('script $src not loaded'));
    },
    onError: (Object e, StackTrace st) {
      // never called
      print('onErrorError: $src');
      completer.completeError(e, st);
    },
    onDone: () {
      // never called
      print('onErrorDone: $src');
    },
  );
  script.onLoad.listen(
    (_) {
      // This is actually the only callback called upon success
      // onError, onDone are never called
      print('dbg_onLoad: $src');
      completer.complete();
    },
    onError: (Object e, StackTrace st) {
      // never called
      print('onError: $src');
      completer.completeError(e, st);
    },
    onDone: () {
      // never called
      print('onDone: $src');
    },
  );
  // ignore: unsafe_html
  script.src = src;
  web.window.document.head!.appendChild(script);
  return completer.future;
}

/// Helper to load a javascript script only once
class JavascriptScriptLoader extends AsyncOnceRunner {
  JavascriptScriptLoader(String src) : super(() => loadJavascriptScript(src));

  bool get loaded => done;

  FutureOr load() => run();
}

Future loadJavascriptScript(String src) {
  var script = web.HTMLScriptElement();
  script.type = 'text/javascript';
  // ignore: unsafe_html
  script.src = src;
  return loaderAppendToHead(script, errorMessage: 'script $src not loaded');
}

/// Append [element] (a script or a stylesheet link) to the document head and
/// complete once loaded, or with an [Exception] of [errorMessage] if it fails
/// to load (each element sends one load or one error event).
Future<void> loaderAppendToHead(
  web.HTMLElement element, {
  required String errorMessage,
}) {
  final completer = Completer<void>();
  StreamSubscription<web.Event>? loadSubscription;
  StreamSubscription<web.Event>? errorSubscription;
  void cancel() {
    loadSubscription?.cancel();
    errorSubscription?.cancel();
  }

  loadSubscription = element.onLoad.listen((_) {
    cancel();
    completer.complete();
  });
  errorSubscription = element.onError.listen((_) {
    cancel();
    completer.completeError(Exception(errorMessage));
  });
  web.document.head!.appendChild(element);
  return completer.future;
}
