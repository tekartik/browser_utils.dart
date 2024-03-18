import 'package:tekartik_browser_utils/browser_utils_import.dart';
import 'package:tekartik_browser_utils/universal_print.dart';

Future main() async {
  print('Loading stylesheet');
  await loadStylesheet('simple_stylesheet.css');
  print('Stylesheet loaded');
}
