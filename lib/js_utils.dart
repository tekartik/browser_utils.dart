library tekartik_browser_utils_js_utils;

import 'dart:js';
import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'package:tekartik_common_utils/async_utils.dart';

part 'src/js_utils/jsobject_converter.dart';

Future debugLoadJavascriptScript(String src) {
  Completer completer = new Completer();
  var script = new ScriptElement();
  print('dbg_loading: ${src}');
  script.type = 'text/javascript';
  script.onError.listen((e) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    print('dbg_onError($e): ${src}');
    completer.completeError(new Exception('script $src not loaded'));
  }, onError: (e, st) {
    // never called
    print('onErrorError: ${src}');
    completer.completeError(e, st);
  }, onDone: () {
    // never called
    print('onErrorDone: ${src}');
  });
  script.onLoad.listen((_) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    print('dbg_onLoad: ${src}');
    completer.complete();
  }, onError: (e, st) {
    // never called
    print('onError: ${src}');
    completer.completeError(e, st);
  }, onDone: () {
    // never called
    print('onDone: ${src}');
  });
  script.src = src;
  document.head.children.add(script);
  return completer.future;
}

/// Helper to load a javascript script only once
class JavascriptScriptLoader extends AsyncOnceRunner {
  JavascriptScriptLoader(String src) : super(() => loadJavascriptScript(src));
  get loaded => done;
  FutureOr load() => run();
}

Future loadJavascriptScript(String src) {
  Completer completer = new Completer();
  var script = new ScriptElement();
  script.type = 'text/javascript';
  script.onError.listen((e) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.completeError(new Exception('script $src not loaded'));
  });
  script.onLoad.listen((_) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.complete();
  });
  script.src = src;
  document.head.children.add(script);
  return completer.future;
}

String jsRuntimeType(JsObject jsObject) {
  return jsObject['constructor']['name'].toString();
}

JsObject jsUint8Array(Uint8List list) {
  return new JsObject(context['Uint8Array'], [list]);
}

bool jsObjectHasLength(JsObject jsObject) {
  return jsObject.hasProperty('length');
}

int jsObjectLength(JsObject jsObject) {
  return jsObject['length'];
}

dynamic jsArrayItem(JsObject jsObject, int index) {
  return jsObject[index];
}

// Good is 2 for deep object
// @return [List]|[Map]
dynamic jsObjectOrAnyAsCollection(dynamic object, {int depth}) {
  if (object is JsObject) {
    return jsObjectAsCollection(object, depth: depth);
  } else if (object == null) {
    return null;
  } else {
    // This does the conversion using the new js package and JS() annotations
    try {
      object = jsObjectAsCollection(new JsObject.fromBrowserObject(object),
          depth: depth);
    } catch (e) {}
    return object;
  }
}

// can be null JsObjact or JsArray
JsObject jsObjectOrAnyAsJsObject(dynamic object) {
  if (object is JsObject) {
    return object;
  } else if (object == null) {
    return null;
  } else {
    // This does the conversion using the new js package and JS() annotations
    try {
      return new JsObject.fromBrowserObject(object);
    } catch (e) {}
    return null;
  }
}

// Good is 2 for deep object
String jsObjectOrAnyToDebugString(dynamic object, {int depth}) {
  if (object == null) {
    return "$object";
  }

  if (object is JsObject) {
    return jsObjectToDebugString(object, depth: depth);
  }
  var jsObject = jsObjectOrAnyAsJsObject(object);
  if (jsObject != null) {
    return jsObjectOrAnyToDebugString(jsObject, depth: depth);
  }

  return object.toString();
}

String jsObjectToDebugString(JsObject jsObject, {int depth}) {
  if (jsObject == null) {
    return null;
  }
  return jsObjectAsCollection(jsObject, depth: depth).toString();
}

bool get _runningAsJavascript => identical(1, 1.0);

@deprecated
bool get runningAsJavascript => _runningAsJavascript;

bool get debugRunningAsJavascript => _runningAsJavascript;
