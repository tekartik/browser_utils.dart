import 'package:dev_test/test.dart';
import 'package:tekartik_browser_utils/universal_console.dart';

void main() {
  group('universalPrint', () {
    test('universalPrint', () {
      universalPrint('first line (universalPrint)');
      print('second line (print)');
    });
  });
}
