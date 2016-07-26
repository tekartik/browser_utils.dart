@TestOn("!vm")
import 'dart:js';
import 'package:tekartik_browser_utils/js_utils.dart';
import 'package:dev_test/test.dart';
//import 'dart:html';

main() {
  group('JsObject', () {
    test('type', () {
      JsObject jsObject = new JsObject.jsify({"test": "value"});
      expect(jsRuntimeType(jsObject), "Object");
      //expect(jsObject.runtimeType, JsObjectImpl);

      JsArray jsArray = new JsArray();
      //expect(jsArray.runtimeType, JsArray);
      expect(jsRuntimeType(jsArray), "Array");

      expect(jsObjectLength(jsObject), null);
      expect(jsObjectLength(jsArray), 0);

      jsObject = new JsObject.jsify([]);
      expect(jsObject is JsArray, isTrue);
      expect(jsRuntimeType(jsObject), "Array");
    });

    test('asMap', () {
      expect(jsObjectAsMap(null), isNull);

      var testDart = {"int": 1, "string": "text", "null": null};
      expect(testDart.toString(), "{int: 1, string: text, null: null}");
      JsObject jsObject = new JsObject.jsify(testDart);
      expect(jsObjectAsMap(jsObject), testDart);

      testDart = {};
      testDart['test'] = testDart;
      expect(testDart.toString(), "{test: {...}}");
      jsObject = new JsObject.jsify({});
      jsObject['test'] = jsObject;
      expect(jsObjectAsMap(jsObject).toString(), "{test: {...}}");
    });

    test('asList', () {
      expect(jsArrayAsList(null), isNull);

      var testDart = [1, "text", null];
      expect(testDart.toString(), "[1, text, null]");
      JsArray jsArray = new JsArray.from(testDart);
      expect(jsArrayAsList(jsArray), testDart);

      testDart = [];
      testDart.add(testDart);
      expect(testDart.toString(), "[[...]]");
      jsArray = new JsArray();
      jsArray.add(jsArray);
      expect(jsArrayAsList(jsArray).toString(), "[[...]]");
    });

    test('asCollection', () {
      expect(jsObjectAsCollection(null), isNull);

      Map map1 = {"int": 1, "string": "text"};
      List list1 = [1, "test", null, 1.1, map1];
      Map map2 = {"map1": map1, "list1": list1};
      List list2 = [list1, map2];
      expect(jsObjectAsCollection(new JsObject.jsify(map2)), map2);
      expect(jsObjectAsCollection(new JsObject.jsify(list2)), list2);
    });

    test('asCollectionDepth', () {
      expect(jsObjectAsCollection(null, depth: 0), isNull);
      expect(jsObjectAsCollection(null, depth: 1), isNull);

      Map map1 = {"int": 1, "string": "text"};
      List list1 = [1, "test", null, 1.1, map1];
      Map map2 = {"map1": map1, "list1": list1};
      List list2 = [list1, map2];

      expect(
          jsObjectAsCollection(new JsObject.jsify(map2), depth: 0), {'.': '.'});
      expect(
          jsObjectAsCollection(new JsObject.jsify(list2), depth: 0), ['..']);
      expect(jsObjectAsCollection(new JsObject.jsify(map2), depth: 1),
          {'map1': {'.': '.'}, 'list1': ['..']});
      expect(
          jsObjectAsCollection(new JsObject.jsify(list2), depth: 1), [['..'], {'.': '.'}]);
    });

    test('toDebugString', () {
      expect(jsObjectToDebugString(null), null);
      expect(jsObjectToDebugString(new JsObject.jsify({})), "{}");
      expect(jsObjectToDebugString(new JsArray()), "[]");
    });

    /* chrome only @TestOn('chrome')
    test('toDebugString_chrome', () {
      expect(jsObjectToDebugString(new JsObject.fromBrowserObject(document)),
          contains("browser"));
    });
    */

    test('loadJs', () async {
      expect(context["tekartik_simple_script_text"], null);
      await loadJavascriptScript("data/simple_script.js");
      //await loadJavascriptScript("https://apis.google.com/js/client.js");
      expect(context["tekartik_simple_script_text"], "hello");
    });
  });
}
