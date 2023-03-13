import 'dart:core' hide print;
import 'dart:core' as core;

import 'package:tekartik_browser_utils/src/console/universal_console.dart';

export 'platform/universal_console_io.dart'
    if (dart.library.html) 'platform/universal_console_web.dart';

/// print.
void print(Object? msg) => universalPrint(msg);
