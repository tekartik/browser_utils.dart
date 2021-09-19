@TestOn('!vm')
library console_utils_test;

import 'package:dev_test/test.dart';
import 'package:tekartik_browser_utils/console_utils.dart';

void main() {
  group('console_utils', () {
    test('printError', () async {
      printError('An error message');
      print('A console message');
      try {
        throw UnsupportedError('testing stack trace');
      } catch (e, st) {
        printError(e, st);
      }
    });
  });
}
