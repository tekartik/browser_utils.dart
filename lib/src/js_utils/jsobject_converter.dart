part of tekartik_browser_utils_js_utils;

List<String> jsObjectKeys(JsObject jsObject) {
  if (jsObject is JsArray) {
    throw new ArgumentError('object is an array');
  }
  JsArray jsKeys = context['Object'].callMethod('keys', [jsObject]);
  List<String> keys = new List();
  for (int i = 0; i < jsKeys.length; i++) {
    keys.add(jsKeys[i]);
  }
  return keys;
}

/**
 * For JsObject of JsArray
 */
dynamic jsObjectAsCollection(JsObject jsObject) {
  if (jsObject is JsArray) {
    return jsArrayAsList(jsObject);
  }
  return jsObjectAsMap(jsObject);
}

List jsArrayAsList(JsArray jsArray) {
  if (jsArray == null) {
    return null;
  }
  _Converter context = new _Converter();
  return context.jsArrayToList(jsArray, []);
}

///
/// Handle element already in jsCollections
///
Map jsObjectAsMap(JsObject jsObject) {
  if (jsObject == null) {
    return null;
  }
  _Converter context = new _Converter();
  return context.jsObjectToMap(jsObject, {});
}

class _Converter {
  Map<JsObject, dynamic> jsCollections = {};
  dynamic jsObjectToCollection(JsObject jsObject) {
    if (jsCollections.containsKey(jsObject)) {
      return jsCollections[jsObject];
    }
    if (jsObject is JsArray) {
      // create the list before
      return jsArrayToList(jsObject, []);
    } else {
      // create the map before for recursive object
      return jsObjectToMap(jsObject, {});
    }
  }

  Map jsObjectToMap(JsObject jsObject, Map map) {
    jsCollections[jsObject] = map;
    List<String> keys = jsObjectKeys(jsObject);

    // Handle recursive objects
    for (String key in keys) {
      var value = jsObject[key];
      if (value is JsObject) {
        // recursive
        value = jsObjectToCollection(value);
      }
      map[key] = value;
    }
    return map;
  }

  List jsArrayToList(JsArray jsArray, List list) {
    jsCollections[jsArray] = list;
    for (int i = 0; i < jsArray.length; i++) {
      var value = jsArray[i];
      if (value is JsObject) {
        value = jsObjectToCollection(value);
      }
      list.add(value);
    }
    return list;
  }
}
