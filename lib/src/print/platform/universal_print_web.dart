import 'package:tekartik_common_utils/out_buffer.dart';
import 'package:web/web.dart' as web;

OutBuffer _outBuffer = OutBuffer(100);
web.Element? outElement;

var lines = <String>[];
void _write(Object? msg) {
  print(msg);
  _outBuffer.add('$msg');
  outElement ??= () {
    var element = web.document.querySelector('#output');
    if (element == null) {
      // Create one
      element = web.HTMLPreElement.pre()..id = 'output';
      web.document.body?.appendChild(element);
    }
    return element;
  }();
  outElement!.text = _outBuffer.toString();
}

void universalPrint(Object? object) {
  _write(object);
}
