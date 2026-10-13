library;

import 'dart:async';

import 'package:tekartik_common_utils/async_utils.dart';
import 'package:web/web.dart' as web;

import 'src/loader_utils.dart' show loaderAppendToHead;

Future<void> loadStylesheet(String src) {
  var link = web.HTMLLinkElement();
  link.type = 'text/css';
  link.href = src;
  link.rel = 'stylesheet';
  return loaderAppendToHead(link, errorMessage: 'stylesheet $src not loaded');
}

/// Helper to load a stylesheet only once
class StylesheetLoader extends AsyncOnceRunner {
  StylesheetLoader(String src) : super(() => loadStylesheet(src));
  bool get loaded => done;
  FutureOr load() => run();
}
