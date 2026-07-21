@TestOn('browser')
library;

import 'dart:js_interop';
import 'dart:typed_data';

import 'package:tekartik_browser_utils/blob_utils.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

void main() {
  group('blob', () {
    test('webBlobUrl', () async {
      var bytes = Uint8List.fromList([1, 2, 3, 4]);
      var url = webBlobUrl(bytes: bytes, mimeType: 'application/octet-stream');
      expect(url, startsWith('blob:'));

      var response = await web.window.fetch(url.toJS).toDart;
      expect(response.headers.get('content-type'), 'application/octet-stream');

      var buffer = await response.arrayBuffer().toDart;
      expect(buffer.toDart.asUint8List(), bytes);

      web.URL.revokeObjectURL(url);
    });
  });
}
