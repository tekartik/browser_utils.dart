import 'package:tekartik_browser_utils/full_screen_utils.dart';
import 'package:tekartik_browser_utils/src/mini_ui.dart';
import 'package:tekartik_browser_utils/universal_print.dart';

Future main() async {
  onFullScreenChange.listen((fullScreen) {
    print('onFullScreenChange: $fullScreen');
  });
  addButton('isFullScreenSupported', () {
    print('isFullScreenSupported: ${isFullScreenSupported()}');
  });
  addButton('isFullScreen', () {
    print('isFullScreen: ${isFullScreen()}');
  });
  addButton('requestFullScreen', () async {
    try {
      await requestFullScreen();
      print('requestFullScreen done');
    } catch (e) {
      print('requestFullScreen refused: $e');
    }
  });
  addButton('exitFullScreen', () async {
    await exitFullScreen();
    print('exitFullScreen done');
  });
}
