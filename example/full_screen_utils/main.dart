import 'package:tekartik_browser_utils/src/mini_ui.dart';
import 'package:tekartik_browser_utils/src/platform/platform.dart';
import 'package:tekartik_browser_utils/universal_print.dart';

Future main() async {
  addButton('isFullScreen', () {
    print('isFullScreen: ${isFullScreen()}');
  });
  addButton('requestFullScreen', () {
    requestFullScreen();
  });
  addButton('exitFullScreen', () {
    exitFullScreen();
  });
}
