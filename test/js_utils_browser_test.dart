@TestOn("!vm")
@JS()
library js_utils_browser_test.dart;

import 'package:dev_test/test.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:tekartik_browser_utils/js_utils.dart';
import 'package:path/path.dart' hide context;

import 'data/js_binding.dart';

//import 'dart:html';

@JS('Car')
class Car {
  external Car();

  external int drive(Object distance);

  external int crash(Object distance);
//external int drive(String distanceText);
}

@anonymous
@JS('WithIntValue')
class WithIntValue {
  external int get value;
  external set value(int value);
  external factory WithIntValue({int value});
}

@JS('tekartik_javascript_script_loader_js_script_text')
external String get javascriptLoaderText;

@JS('tekartik_javascript_script_loader_js_script_text')
external set javascriptLoaderText(String text);

main() {
  setUpAll(() {
    loadJavascriptScript('js_utils_browser_test.js');
  });
  group('JsObject', () {
    test('anonymous', () {
      var withIntValue = new WithIntValue();
      expect(jsObjectKeys(withIntValue), []);
      withIntValue.value = 1;
      expect(jsObjectKeys(withIntValue), ['value']);
      expect(withIntValue.value, 1);
      // print('withIntValue ${withIntValue.value}');
    });

    test('type', () {
      var jsObject = jsify({"test": "value"});
      expect(jsRuntimeType(jsObject), "Object");

      var jsArray = jsify([]);
      expect(jsRuntimeType(jsArray), "Array");
    });

    test('jsObjectAsMap', () {
      expect(jsObjectAsMap(null), null);
      var jsObject = newObject();
      expect(jsObjectAsMap(jsObject), {});
      setProperty(jsObject, 'value', 1);
      expect(jsObjectAsMap(jsObject), {'value': 1});

      var withIntValue = new WithIntValue();
      expect(jsObjectAsMap(withIntValue), {});
      withIntValue.value = 1;
      expect(jsObjectAsMap(withIntValue), {'value': 1});
    });

    test('jsObjectAsMapRecursive', () {
      var testDart = {"int": 1, "string": "text", "null": null};
      var jsObject = jsify(testDart);
      expect(jsObjectAsMap(jsObject), testDart);

      testDart = {};
      testDart['test'] = testDart;
      expect(testDart.toString(), "{test: {...}}");
      jsObject = jsify({});
      setProperty(jsObject, 'test', jsObject);
      //TODO
      //expect(jsObjectAsMap(jsObject).toString(), "{test: {...}}");
      expect(jsObjectAsMap(jsObject).toString(), "{test: {test: {...}}}");
    });

    test('asList', () {
      expect(jsArrayAsList(null), isNull);

      var testDart = [1, "text", null];
      expect(testDart.toString(), "[1, text, null]");
      var jsArray = jsify(testDart);
      expect(jsArrayAsList(jsArray as List), testDart);

      testDart = [];
      testDart.add(testDart);
      expect(testDart.toString(), "[[...]]");
      jsArray = jsify([]);
      jsArray.add(jsArray);
      expect(jsArrayAsList(jsArray as List).toString(), "[[...]]");
    });

    test('asCollection', () {
      expect(jsObjectAsCollection(null), isNull);

      Map map1 = {"int": 1, "string": "text"};
      List list1 = [1, "test", null, 1.1, map1];
      Map map2 = {"map1": map1, "list1": list1};
      List list2 = [list1, map2];
      expect(jsObjectAsCollection(jsify(map2)), map2);
      expect(jsObjectAsCollection(jsify(list2)), list2);
    });

    test('asCollectionDepth', () {
      expect(jsObjectAsCollection(null, depth: 0), isNull);
      expect(jsObjectAsCollection(null, depth: 1), isNull);

      Map map1 = {"int": 1, "string": "text"};
      List list1 = [1, "test", null, 1.1, map1];
      Map map2 = {"map1": map1, "list1": list1};
      List list2 = [list1, map2];

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
      // print("car.runtimeType: ${car.runtimeType}");

      // On firefox ?XXJsLinkedHashMap on chorme _InternalLinkedHashMap
      // Chrome: JsObject
      // print("fromBrowser(car).runtimeType: ${new JsObject.fromBrowserObject(car).runtimeType}");
      // On firefox JsLinkedHashMap on chorme _InternalLinkedHashMap
      // print(jsObjectOrAnyAsCollection(new Car()).runtimeType);


      if (debugRunningAsJavascript) {
        expect(jsObjectOrAnyAsCollection(car), {
          "o": {"distance": 0, "drive": {}}
        });
      } else {
        expect(jsObjectOrAnyAsCollection(car), {"distance": 0, "drive": {}});
      }
      */

      //expect(jsObjectOrAnyAsCollection(new Car()), {"distance": 0, "drive": {}});
    });

    test('toDebugString', () {
      expect(jsObjectToDebugString(null), null);
      expect(jsObjectToDebugString(jsify({})), "{}");
      expect(jsObjectToDebugString(jsify([])), "[]");
    });

    /* chrome only @TestOn('chrome')
    test('toDebugString_chrome', () {
      expect(jsObjectToDebugString(new JsObject.fromBrowserObject(document)),
          contains("browser"));
    });
    */

    test('loadJs', () async {
      expect(tekartikSimpleScriptText, null);
      await loadJavascriptScript("data/simple_script.js");
      //await loadJavascriptScript("https://apis.google.com/js/client.js");
      expect(tekartikSimpleScriptText, "hello");

      bool failed = false;
      try {
        await loadJavascriptScript("data/NOT_EXISTS.js");
      } catch (e) {
        failed = true;
        //print(e);
      }
      expect(failed, isTrue, reason: "script does not exits");
    });

    test('JavascriptScriptLoader', () async {
      final JavascriptScriptLoader loader = new JavascriptScriptLoader(
          url.join('data', 'javascript_script_loader_js_script.js'));
      expect(loader.loaded, isFalse);
      expect(javascriptLoaderText, isNull);
      await loader.load();
      expect(javascriptLoaderText, "hello");
      expect(loader.loaded, isTrue);
      javascriptLoaderText = "new_hello";
      expect(javascriptLoaderText, "new_hello");
      await loader.load();
      expect(javascriptLoaderText, "new_hello");
    });

    // Skipped when not debugging
    test('debugLoadJs', () async {
      expect(tekartikDebugLoadJsScriptText, null);
      await debugLoadJavascriptScript("data/debug_load_js_script.js");
      expect(tekartikDebugLoadJsScriptText, "hello");
      await debugLoadJavascriptScript("data/debug_load_js_script.js");
    }, skip: true);

    // Skipped when not debugging
    test('debugLoadBadJs', () async {
      bool failed = false;
      try {
        await debugLoadJavascriptScript("data/NOT_EXISTS.js");
      } catch (e) {
        failed = true;
        print(e);
      }
      expect(failed, isTrue, reason: "script does not exits");
    }, skip: true);
  });
}
