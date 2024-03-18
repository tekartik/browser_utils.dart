import 'dart:js_interop';

import 'package:stack_trace/stack_trace.dart';
import 'package:web/web.dart' as web;

void printError(Object? e, [StackTrace? st]) {
  try {
    web.console.error(e.toString().toJS);
  } catch (_) {
    print(e);
  }
  if (st != null) {
    try {
      web.console.error(Trace.format(st).toJS);
    } catch (_) {
      print(st);
    }
    //devPrint(st);
  }
}
