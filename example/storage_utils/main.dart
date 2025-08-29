import 'package:tekartik_browser_utils/src/mini_ui.dart';
import 'package:tekartik_browser_utils/src/platform/platform.dart';
import 'package:tekartik_browser_utils/universal_print.dart';

Future main() async {
  addButton('Print Hello', () {
    print('Hello');
  });
  var sessionKey = 'testSessionKey';
  int sessionStorageIncrement() {
    var value = int.tryParse(webSessionStorageGet(sessionKey) ?? '') ?? 0;
    value++;
    webSessionStorageSet(sessionKey, value.toString());
    print(webSessionStorageGet(sessionKey));
    return value;
  }

  addButton('webSessionStorageIncrement', () {
    sessionStorageIncrement();
  });
  addButton('webSessionStorageGet', () {
    print(webSessionStorageGet(sessionKey));
  });
  addButton('webSessionStorageRemove', () {
    webSessionStorageRemove(sessionKey);
  });
  var localKey = 'testLocalKey';
  int localStorageIncrement() {
    var value = int.tryParse(webLocalStorageGet(localKey) ?? '') ?? 0;
    value++;
    webLocalStorageSet(localKey, value.toString());
    print(webLocalStorageGet(localKey));
    return value;
  }

  addButton('webLocalStorageIncrement', () {
    localStorageIncrement();
  });
  addButton('webLocalStorageGet', () {
    print(webLocalStorageGet(localKey));
  });
  addButton('webLocalStorageRemove', () {
    webLocalStorageRemove(localKey);
  });
  Uri newUri() {
    var value = sessionStorageIncrement().toString();
    var uri = Uri.base.replace(queryParameters: {'param': value});
    print(uri);
    return uri;
  }

  addButton('reload', () {
    webReload(uri: newUri());
  });
  addButton('openInSamePage', () {
    webOpenInSameTab(newUri());
  });
}
