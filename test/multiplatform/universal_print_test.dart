import 'package:tekartik_browser_utils/universal_print.dart';
import 'package:test/test.dart';

void main() {
  group('universalPrint', () {
    test('universalPrint', () {
      universalPrint('first line (universalPrint)');
      print('second line (print)');
    });
  });
}
