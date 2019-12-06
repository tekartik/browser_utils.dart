import 'package:js/js_util.dart';

const String jsArrayType = 'Array';
const String jsObjectType = 'Object';

String jsRuntimeType(dynamic jsObject) {
  var constructor = getProperty(jsObject, 'constructor');
  if (constructor == null) {
    throw 'no constructor';
  }
  return getProperty(constructor, 'name').toString();
}

bool isJsArray(dynamic jsObject) {
  return jsRuntimeType(jsObject) == jsArrayType;
}

bool isJsObject(dynamic jsObject) {
  return jsRuntimeType(jsObject) == jsObjectType;
}
