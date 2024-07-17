// Copyright (c) 2016, Alexandre Roux Tekartik. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:tekartik_browser_utils/language_utils.dart';
import 'package:tekartik_common_utils/env_utils.dart';
import 'package:test/test.dart';

void main() {
  group('language', () {
    test('webNavigatorLanguage', () {
      if (kDartIsWeb) {
        webNavigatorLanguage;
      } else {
        expect(() => webNavigatorLanguage, throwsUnsupportedError);
      }
    });
  });
}
