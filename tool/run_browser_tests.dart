import 'dart:async';

import 'package:process_run/shell_run.dart';

Future main() async {
  await run('dart pub run build_runner test -- -p chrome -r expanded');
}
