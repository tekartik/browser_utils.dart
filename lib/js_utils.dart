library tekartik_browser_utils_js_utils;

import 'dart:js';
import 'dart:async';
import 'dart:html';
import 'dart:typed_data';

part 'src/js_utils/jsobject_converter.dart';

Future debugLoadJavascriptScript(String src) {
  Completer completer = new Completer();
  var script = new ScriptElement();
  script.type = 'text/javascript';
  script.onError.listen((e) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.completeError(new Exception('script $src not loaded'));
  }, onError: (e, st) {
    // never called
    print('onErrorError');
    completer.completeError(e, st);
  }, onDone: () {
    // never called
    print('onErrorDone');
  });
  script.onLoad.listen((_) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.complete();
  }, onError: (e, st) {
    // never called
    print('onError');
    completer.completeError(e, st);
  }, onDone: () {
    // never called
    print('onDone');
  });
  script.src = src;
  document.head.children.add(script);
  return completer.future;
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

String jsObjectOrAnyToDebugString(dynamic object) {
  if (object is JsObject) {
    return jsObjectToDebugString(object);
  } else if (object == null) {
    return null;
  } else {
    return object.toString();
  }
}

String jsObjectToDebugString(JsObject jsObject) {
  if (jsObject == null) {
    return null;
  }
  return jsObjectAsCollection(jsObject).toString();
}
