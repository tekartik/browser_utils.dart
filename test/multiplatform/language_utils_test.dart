// Copyright (c) 2016, Alexandre Roux Tekartik. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dev_test/test.dart';
import 'package:tekartik_browser_utils/language_utils.dart';
import 'package:tekartik_common_utils/env_utils.dart';

void main() {
  group('language', () {
    test('webNavigatorLanguage', () {
      if (isRunningAsJavascript) {
        webNavigatorLanguage;
      } else {
        expect(() => webNavigatorLanguage, throwsUnsupportedError);
      }
    });
  });
}
