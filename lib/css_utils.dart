library tekartik_browser_utils_css_utils;

import 'dart:async';
import 'dart:html';

import 'package:tekartik_common_utils/async_utils.dart';

Future loadStylesheet(String src) {
  final completer = Completer<void>();
  var link = LinkElement();
  link.type = 'text/css';
  link.onError.listen((e) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.completeError(Exception('stylesheet $src not loaded'));
  });
  link.onLoad.listen((_) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.complete();
  });
  link.href = src;
  link.rel = 'stylesheet';
  document.head!.children.add(link);
  return completer.future;
}

/// Helper to load a javascript script only once
class StylesheetLoader extends AsyncOnceRunner {
  StylesheetLoader(String src) : super(() => loadStylesheet(src));
  bool get loaded => done;
  FutureOr load() => run();
}
