@JS()
library tekartik_browser_tuils.test.data.js_bindings;

// ignore: depend_on_referenced_packages
import 'package:js/js.dart';

@JS('tekartik_simple_script_text')
external String get tekartikSimpleScriptText;

@JS('tekartik_debug_load_js_script_text')
external String get tekartikDebugLoadJsScriptText;
