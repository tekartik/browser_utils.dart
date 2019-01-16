import 'dart:async';

import 'package:process_run/cmd_run.dart';

Future main() async {
  // pub run build_runner test --fail-on-severe -- -p chrome -r expanded
  await runCmd(
      PbrCmd(
          ['test', '--fail-on-severe', '--', '-p', 'chrome', '-r', 'expanded']),
      verbose: true);
}
