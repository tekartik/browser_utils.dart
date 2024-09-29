@TestOn('browser && !wasm')
@JS()
library;

// ignore: depend_on_referenced_packages
import 'package:js/js.dart';
// ignore: depend_on_referenced_packages
import 'package:js/js_util.dart';
import 'package:tekartik_js_utils/js_utils.dart';
import 'package:test/test.dart';

//import 'dart:html';

@JS('Car')
class Car {
  external Car();

  external int drive(num distance);

  external int crash(num distance);
//external int drive(String distanceText);
}

@anonymous
@JS('WithIntValue')
class WithIntValue {
  external int get value;

  external set value(int value);

  external factory WithIntValue({int? value});
}

void main() {
  group('JsObject', () {
    test('anonymous', () {
      var withIntValue = WithIntValue();
      expect(jsObjectKeys(withIntValue), isEmpty);
      withIntValue.value = 1;
      expect(jsObjectKeys(withIntValue), ['value']);
      expect(withIntValue.value, 1);
      // print('withIntValue ${withIntValue.value}');
    });

    test('type', () {
      var jsObject = jsify({'test': 'value'}) as Object;
      expect(jsRuntimeType(jsObject), 'Object');

      var jsArray = jsify([]) as Object;
      expect(jsRuntimeType(jsArray), 'Array');
    });

    test('jsObjectAsMap', () {
      expect(jsObjectAsMap(null), null);
      var jsObject = newObject() as Object;
      expect(jsObjectAsMap(jsObject), isEmpty);
      setProperty(jsObject, 'value', 1);
      expect(jsObjectAsMap(jsObject), {'value': 1});

      var withIntValue = WithIntValue();
      expect(jsObjectAsMap(withIntValue), isEmpty);
      withIntValue.value = 1;
      expect(jsObjectAsMap(withIntValue), {'value': 1});
    });

    test('jsObjectAsMapRecursive', () {
      var testDart = {'int': 1, 'string': 'text', 'null': null};
      var jsObject = jsify(testDart) as Object;
      expect(jsObjectAsMap(jsObject), testDart);

      testDart = {};
      testDart['test'] = testDart;
      expect(testDart.toString(), '{test: {...}}');
      jsObject = jsify({}) as Object;
      setProperty(jsObject, 'test', jsObject);
      //TODO
      //expect(jsObjectAsMap(jsObject).toString(), '{test: {...}}');
      expect(jsObjectAsMap(jsObject).toString(), '{test: {test: {...}}}');
    });

    test('asList', () {
      expect(jsArrayAsList(null), isNull);

      var testDart = [1, 'text', null];
      expect(testDart.toString(), '[1, text, null]');
      var jsArray = jsify(testDart);
      expect(jsArrayAsList(jsArray as List?), testDart);

      testDart = [];
      testDart.add(testDart);
      expect(testDart.toString(), '[[...]]');
      jsArray = jsify([]) as List;
      // ignore: avoid_dynamic_calls
      jsArray.add(jsArray);
      expect(jsArrayAsList(jsArray).toString(), '[[...]]');
    });

    test('asCollection', () {
      expect(jsObjectAsCollection(null), isNull);

      final map1 = {'int': 1, 'string': 'text'};
      final list1 = [1, 'test', null, 1.1, map1];
      final map2 = {'map1': map1, 'list1': list1};
      final list2 = [list1, map2];
      expect(jsObjectAsCollection(jsify(map2)), map2);
      expect(jsObjectAsCollection(jsify(list2)), list2);
    });

    test('asCollectionDepth', () {
      expect(jsObjectAsCollection(null, depth: 0), isNull);
      expect(jsObjectAsCollection(null, depth: 1), isNull);

      var map1 = {'int': 1, 'string': 'text'};
      var list1 = [1, 'test', null, 1.1, map1];
      var map2 = {'map1': map1, 'list1': list1};
      var list2 = [list1, map2];

      expect(jsObjectAsCollection(jsify(map2), depth: 0), {'.': '.'});
      expect(jsObjectAsCollection(jsify(list2), depth: 0), ['..']);
      expect(jsObjectAsCollection(jsify(map2), depth: 1), {
        'map1': {'.': '.'},
        'list1': ['..']
      });
      expect(jsObjectAsCollection(jsify(list2), depth: 1), [
        ['..'],
        {'.': '.'}
      ]);
    });

    test('jsObjectOrAnyAsJsObject', () {
      /*
      // print(jsObjectOrAnyAsJsObject(null));
      // print(jsObjectToDebugString(jsObjectOrAnyAsJsObject(new JsObject.jsify({}))));
      // print(jsObjectOrAnyAsJsObject(1));
      expect(jsObjectOrAnyAsJsObject(null), null);
      expect(jsObjectOrAnyAsJsObject(1), null);
      expect(jsObjectOrAnyAsCollection(new JsObject.jsify({})), {});
      //print(jsObjectOrAnyAsJsObject(new Car()));
      expect(jsObjectOrAnyAsJsObject(new Car()), const TypeMatcher<JsObject>());
      // {distance: 0, drive: {}}
      // print(jsObjectOrAnyAsCollection(new Car()));

      //Map carCollection = jsObjectOrAnyAsCollection(new Car());
      // firefox
      // {o: {distance: 0, drive: {}}}
      // print('carCollection: ${carCollection}');

      Car car = new Car();

      // On firefox ?XXJsLinkedHashMap on chorme _InternalLinkedHashMap
      // Chrome: JsObjectImpl
      // print('car.runtimeType: ${car.runtimeType}');

      // On firefox ?XXJsLinkedHashMap on chorme _InternalLinkedHashMap
      // Chrome: JsObject
      // print('fromBrowser(car).runtimeType: ${new JsObject.fromBrowserObject(car).runtimeType}');
      // On firefox JsLinkedHashMap on chorme _InternalLinkedHashMap
      // print(jsObjectOrAnyAsCollection(new Car()).runtimeType);


      if (debugRunningAsJavascript) {
        expect(jsObjectOrAnyAsCollection(car), {
          'o': {'distance': 0, 'drive': {}}
        });
      } else {
        expect(jsObjectOrAnyAsCollection(car), {'distance': 0, 'drive': {}});
      }
      */

      //expect(jsObjectOrAnyAsCollection(new Car()), {'distance': 0, 'drive': {}});
    });

    test('toDebugString', () {
      expect(jsObjectToDebugString(null), null);
      expect(jsObjectToDebugString(jsify({})), '{}');
      expect(jsObjectToDebugString(jsify([])), '[]');
    });

    /* chrome only @TestOn('chrome')
    test('toDebugString_chrome', () {
      expect(jsObjectToDebugString(new JsObject.fromBrowserObject(document)),
          contains('browser'));
    });
    */
  });
}
