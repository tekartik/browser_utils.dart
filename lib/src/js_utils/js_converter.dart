import 'package:js/js_util.dart';
import 'package:tekartik_browser_utils/src/js_utils/js_interop.dart';
import 'package:tekartik_browser_utils/src/js_utils/js_utils.dart';

/**
 * For JsObject of JsArray
 */
dynamic jsObjectAsCollection(dynamic jsObject, {int depth}) {
  if (jsObject is List) {
    return jsArrayAsList(jsObject, depth: depth);
  }
  return jsObjectAsMap(jsObject, depth: depth);
}

List jsArrayAsList(dynamic jsArray, {int depth}) {
  if (jsArray == null) {
    return null;
  }
  var converter = new _Converter();
  return converter.jsArrayToList(jsArray, [], depth: depth);
}

///
/// Handle element already in jsCollections
///
Map jsObjectAsMap(dynamic jsObject, {int depth}) {
  if (jsObject == null) {
    return null;
  }
  var converter = new _Converter();
  return converter.jsObjectToMap(jsObject, {}, depth: depth);
}

bool jsIsCollection(dynamic jsObject) {
  return jsObject != null &&
      (jsObject is Iterable ||
          jsObject is Map ||
          isJsArray(jsObject) ||
          isJsObject(jsObject));
}

bool jsIsList(dynamic jsObject) {
  return jsObject is Iterable || isJsArray(jsObject);
}

class _Converter {
  Map<dynamic, dynamic> jsCollections = {};

  dynamic jsObjectToCollection(dynamic jsObject, {int depth}) {
    if (jsCollections.containsKey(jsObject)) {
      return jsCollections[jsObject];
    }
    if (jsIsList(jsObject)) {
      // create the list before
      return jsArrayToList(jsObject, [], depth: depth);
    } else {
      // create the map before for recursive object
      return jsObjectToMap(jsObject, {}, depth: depth);
    }
  }

  Map jsObjectToMap(dynamic jsObject, Map map, {int depth}) {
    jsCollections[jsObject] = map;
    List<String> keys = jsObjectKeys(jsObject);

    // Stop
    if (depth == 0) {
      return {".": "."};
    }

    // Handle recursive objects
    for (String key in keys) {
      var value = getProperty(jsObject, key);
      if (jsIsCollection(value)) {
        // recursive
        value = jsObjectToCollection(value,
            depth: depth == null ? null : depth - 1);
      }
      map[key] = value;
    }
    return map;
  }

  List jsArrayToList(dynamic jsArray, List list, {int depth}) {
    if (depth == 0) {
      return [".."];
    }
    jsCollections[jsArray] = list;
    for (int i = 0; i < jsArray.length; i++) {
      var value = jsArray[i];
      if (jsIsCollection(value)) {
        value = jsObjectToCollection(value,
            depth: depth == null ? null : depth - 1);
      }
      list.add(value);
    }
    return list;
  }
}

String jsRuntimeType(dynamic jsObject) {
  var constructor = getProperty(jsObject, 'constructor');
  if (constructor == null) {
    throw 'no constructor';
  }
  return getProperty(constructor, 'name').toString();
}
