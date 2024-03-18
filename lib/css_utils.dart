library tekartik_browser_utils_css_utils;

import 'dart:async';
import 'dart:js_interop';

import 'package:tekartik_common_utils/async_utils.dart';
import 'package:web/web.dart' as web;

Future<void> loadStylesheet(String src) {
  final completer = Completer<void>();
  var link = web.HTMLLinkElement();
  link.type = 'text/css';
  var zone = Zone.current;
  print('loading $src');
  link.onerror = (web.Event e) {
    zone.run(() {
      print('error $e');
      completer.completeError(Exception('stylesheet $src not loaded'));
    });
    // This is actually the only callback called upon success
    // onError, onDone are never called
  }.toJS;
  link.onload = (web.Event e) {
    zone.run(() {
      print('onLoad');
      // This is actually the only callback called upon success
      // onError, onDone are never called
      completer.complete();
    });
  }.toJS;

  link.href = src;
  link.rel = 'stylesheet';
  web.document.head!.appendChild(link);
  return completer.future;
}

/// Helper to load a javascript script only once
class StylesheetLoader extends AsyncOnceRunner {
  StylesheetLoader(String src) : super(() => loadStylesheet(src));
  bool get loaded => done;
  FutureOr load() => run();
}
