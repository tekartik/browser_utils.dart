@JS()
library tekartik_browser_utils.js_interop;

import 'package:js/js.dart';

@JS("Object.keys")
external List<String> jsObjectKeys(Object obj);
