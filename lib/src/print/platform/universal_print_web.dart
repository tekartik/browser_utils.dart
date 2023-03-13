import 'dart:html';
import 'package:tekartik_common_utils/out_buffer.dart';

OutBuffer _outBuffer = OutBuffer(100);
Element? outElement;

var lines = <String>[];
void _write(Object? msg) {
  print(msg);
  _outBuffer.add('$msg');
  outElement ??= () {
    var element = querySelector('#output');
    if (element == null) {
      // Create one
      element = Element.pre()..id = 'output';
      document.body?.append(element);
    }
    return element;
  }();
  outElement!.text = _outBuffer.toString();
}

void universalPrint(Object? object) {
  _write(object);
}
