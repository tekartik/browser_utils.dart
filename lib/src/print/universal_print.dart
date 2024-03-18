import 'dart:core' hide print;
import 'dart:core' as core;

import 'package:tekartik_browser_utils/src/print/universal_print.dart';

export 'platform/universal_print_io.dart'
    if (dart.library.js_interop) 'platform/universal_print_web.dart';

/// print.
void print(Object? msg) => universalPrint(msg);
