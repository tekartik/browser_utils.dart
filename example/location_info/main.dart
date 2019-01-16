import 'dart:async';
import 'dart:html';

import 'package:tekartik_browser_utils/location_info_utils.dart';
import 'package:tekartik_browser_utils/src/location_info_utils.dart';
import 'package:tekartik_common_utils/out_buffer.dart';
import 'package:tekartik_common_utils/json_utils.dart';

OutBuffer _outBuffer = OutBuffer(100);
Element _output = document.getElementById("output");
void write([Object message]) =>
    _output.text = (_outBuffer..add("$message")).toString();

Future main() async {
  BrowserLocationInfo info = locationInfo as BrowserLocationInfo;
  write(jsonPretty(info.toDebugMap()));
}
