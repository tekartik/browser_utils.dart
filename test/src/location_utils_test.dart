@TestOn('browser')
library;

import 'package:tekartik_browser_utils/location_info_utils.dart';
import 'package:tekartik_browser_utils/src/location_info_utils.dart';
import 'package:test/test.dart';

void main() {
  group('location', () {
    test('browser', () {
      final localLocationInfo = locationInfo as BrowserLocationInfo;
      print(localLocationInfo.toDebugMap());
//      expect(locationInfo.path, contains('location_utils_test.html'));
      //print('_locationInfo.location.protocol);
    });
  });
}
