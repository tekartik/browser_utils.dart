// Copyright (c) 2016, Alexandre Roux Tekartik. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:tekartik_browser_utils/src/location_info_common_utils.dart';
import 'package:test/test.dart';

void main() {
  group('location', () {
    test('fromLocation', () {
      final locationInfo = MockLocationInfo();
      expect(locationInfo.arguments, isNotNull);
    });

    test('locationSearchGetArguments', () {
      Map<String, String> params;

      params = locationSearchGetArguments('?t=1');
      expect(params.length, equals(1));
      expect(params['t'], equals('1'));
      expect(params['y'], isNull);

      params = locationSearchGetArguments('t=1');
      expect(params.length, equals(1));
      expect(params['t'], equals('1'));
      expect(params['y'], isNull);

      params = locationSearchGetArguments('/fulluri/yeap?t=1');
      expect(params.length, equals(1));
      expect(params['t'], equals('1'));
      expect(params['y'], isNull);

      expect(locationSearchGetArguments('?tata&log=info&tutu=1')['tutu'],
          equals('1'));
      expect(locationSearchGetArguments('?tata&log=info&tutu=1')['tata'],
          equals(''));
      expect(locationSearchGetArguments('tata&log=info&tutu=1')['tata'],
          equals(''));
      expect(locationSearchGetArguments('tata&log=info&tutu=1')['tata'],
          equals(''));
      expect(locationSearchGetArguments(null).isEmpty, isTrue);

      // Handle decoding
      final search =
          'state=%7B"ids":%5B"0B4xfXXDGtr7XbGZvaGZadlAtb1U"%5D,"action":"open","userId":"106049382465267012344"%7D';
      //Map map = Uri.splitQueryString(search); // this fails as it does not handle the ?
      final map = locationSearchGetArguments(search);
      //print(map['state']);
      expect(map['state']!.startsWith('{"ids":["0B4x'), isTrue);
      //String uri = 'http://milomedy.tekartik.com/?state=%7B%22ids%22:%5B%220B4xfXXDGtr7XbGZvaGZadlAtb1U%22%5D,%22action%22:%22open%22,%22userId%22:%22106049382465267012344%22%7D';
      //Uri.parse(uri)
    });
  });
}
