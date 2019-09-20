import 'dart:io';

import 'package:process_run/shell.dart';
import 'package:pub_semver/pub_semver.dart';

Version parsePlatformVersion(String text) {
  return Version.parse(text.split(' ').first);
}

Future main() async {
  var shell = Shell();

  await shell.run('''

  dartanalyzer --fatal-warnings lib test tool example
  dartfmt -w lib test tool example --set-exit-if-changed

  pub run test -p vm
  pub run test -p chrome,firefox
  # pub run build_runner test -- -p vm test/multiplatform
  
  ''');

  // Fails on Dart 2.1.1
  // Fail on Firefox on Dart 2.3.1
  var dartVersion = parsePlatformVersion(Platform.version);
  if (dartVersion >= Version(2, 2, 0, pre: 'dev')) {
    await shell.run('''
    pub run build_runner test -- -p chrome
  ''');
  }

  await shell.run('''
  # test dartdevc support
  pub run build_runner build --no-release example -o example:build/example_debug
  pub run build_runner build -r example -o example:build/example_release

  ''');
}
