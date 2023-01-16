@TestOn('browser')
// Copyright (c) 2016, Alexandre Roux Tekartik. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dev_test/test.dart';
import 'package:tekartik_browser_utils/location_info_utils.dart';
import 'package:tekartik_browser_utils/src/location_info_utils.dart';

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
