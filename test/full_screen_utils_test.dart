@TestOn('browser')
library;

import 'package:tekartik_browser_utils/full_screen_utils.dart';
import 'package:test/test.dart';

void main() {
  group('full_screen_utils', () {
    test('isFullScreen', () {
      expect(isFullScreen(), isFalse);
    });
    test('isFullScreenSupported', () {
      expect(isFullScreenSupported(), isA<bool>());
    });
    test('exitFullScreen when not full screen', () async {
      // Must not reject.
      await exitFullScreen();
      expect(isFullScreen(), isFalse);
    });
    test('requestFullScreen without a user gesture', () async {
      // Refused by the browser (no gesture), or, on a permissive test
      // browser, granted: both must leave the document in a sane state.
      try {
        await requestFullScreen();
      } catch (e) {
        expect(isFullScreen(), isFalse);
        return;
      }
      await exitFullScreen();
      expect(isFullScreen(), isFalse);
    });
    test('onFullScreenChange', () async {
      var subscription = onFullScreenChange.listen((_) {});
      await subscription.cancel();
    });
  });
}
