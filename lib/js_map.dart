// Wraps JSObjectImpl to allow key-value access, not available in js.dart 0.6.1
// credit to @matanlurey and @a14n for helping me with this:
//    https://github.com/dart-lang/sdk/issues/28194#issuecomment-269051789

@JS()
library jsmap;

import 'dart:collection';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('Object.keys')
external List<String> _getKeys(Object jsObject);

class JsMap<V> extends MapBase<String, dynamic> {
  final Object _jsObject;

  JsMap(this._jsObject);

  @override
  V? operator [](Object? key) {
    var prop = getProperty<Object?>(_jsObject, key.toString());
    if (prop != null) {
      // if the map is not generic
      if (V == dynamic) {
        prop = JsMap<Object?>(prop);
      }
    }

    return prop as V?;
  }

  @override
  operator []=(String key, dynamic value) =>
      setProperty<Object>(_jsObject, key.toString(), value);

  @override
  dynamic remove(Object? key) {
    throw 'Not implemented yet for JsMap, sorry';
  }

  @override
  Iterable<String> get keys => _getKeys(_jsObject);

  @override
  bool containsKey(Object? key) => hasProperty(_jsObject, key!);

  @override
  void clear() {
    throw 'Not implemented yet for JsMap, sorry';
  }
}
