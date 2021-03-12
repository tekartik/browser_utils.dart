import 'package:dev_test/package.dart';
import 'package:process_run/shell.dart';

Future main() async {
  var shell = Shell(
      environment:
          // Prevent firefox from popping up
          Map.from(userEnvironment)..['MOZ_HEADLESS'] = '1');

  // Common ci test
  await packageRunCi('.', noAnalyze: true);

  await shell.run('''
  # Firefox test
  dart test -p firefox
  # dart pub run build_runner build --no-release example -o example:build/example_debug
  # dart pub run build_runner build -r example -o example:build/example_release
  ''');
}
