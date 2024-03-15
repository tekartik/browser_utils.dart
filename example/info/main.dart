import 'package:tekartik_browser_utils/language_utils.dart';
import 'package:tekartik_browser_utils/universal_print.dart';
import 'package:tekartik_common_utils/env_utils.dart';

Future main() async {
  if (isRunningAsJavascript) {
    print('webNavigatorLanguage: $webNavigatorLanguage');
  }
  print('kDartIsWeb: $kDartIsWeb');
  print('isRunningAsJavascript: $isRunningAsJavascript');
}
