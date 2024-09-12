import 'package:tekartik_browser_utils/src/mini_ui.dart';
import 'package:tekartik_browser_utils/src/platform/platform.dart';
import 'package:tekartik_browser_utils/universal_print.dart';

Future main() async {
  addButton('Print Hello', () {
    print('Hello');
  });
  addButton('webOpenInSameTab', () {
    webOpenInSameTab(Uri.parse('https://tekartik.com'));
  });
  addButton('webOpenInNewTab', () {
    webOpenInNewTab(Uri.parse('https://tekartik.com'));
  });
  addButton('webOpenInNewWindow', () {
    webOpenInNewWindow(Uri.parse('https://tekartik.com'));
  });
}
