@TestOn('browser')
library;

import 'dart:async';

import 'package:tekartik_browser_utils/src/window_utils.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

/// An iframe on [src], once loaded.
Future<web.HTMLIFrameElement> _iframe(String src) async {
  var iframe = web.HTMLIFrameElement()..src = src;
  var loaded = iframe.onLoad.first;
  web.document.body!.appendChild(iframe);
  await loaded;
  return iframe;
}

void main() {
  group('locationReload', () {
    test('uri', () async {
      var iframe = await _iframe('data/reload_page.html?param=0');
      try {
        var loaded = iframe.onLoad.first;
        locationReload(
          iframe.contentWindow!.location,
          uri: Uri.parse('reload_page.html?param=1'),
        );
        await loaded;
        // A reload right after the navigation would have cancelled it.
        await Future<void>.delayed(const Duration(milliseconds: 500));
        expect(iframe.contentWindow!.location.search, '?param=1');
      } finally {
        iframe.remove();
      }
    });

    test('fragment only uri reloads', () async {
      var iframe = await _iframe('data/reload_page.html?param=0');
      try {
        var loaded = iframe.onLoad.first;
        locationReload(
          iframe.contentWindow!.location,
          uri: Uri.parse('reload_page.html?param=0#frag'),
        );
        await loaded;
        var location = iframe.contentWindow!.location;
        expect(location.search, '?param=0');
        expect(location.hash, '#frag');
      } finally {
        iframe.remove();
      }
    });
  });
}
