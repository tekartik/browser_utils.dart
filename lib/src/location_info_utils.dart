import 'dart:html';

import 'package:tekartik_browser_utils/src/location_info_common_utils.dart';

class BrowserLocationInfo implements LocationInfo {
  final Location location;
  // never null
  @override
  final Map<String, String> arguments;
  BrowserLocationInfo(this.location)
      : arguments = locationSearchGetArguments(location.search);

  @override
  String get host => location.host;

  @override
  String? get path => location.pathname;

  @override
  String toString() => toMap().toString();

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'host': host, 'path': path};
    if (arguments.isNotEmpty) {
      map['arguments'] = arguments;
    }
    return map;
  }

  Map<String, dynamic> toDebugMap() {
    final map = toMap();
    final loc = <String, dynamic>{};
    loc['protocol'] = location.protocol;
    loc['pathname'] = location.pathname;
    loc['search'] = location.search;
    loc['href'] = location.href;
    loc['hostname'] = location.hostname;
    loc['port'] = location.port;
    loc['origin'] = location.origin;
    loc['host'] = location.host;
    map['location'] = loc;
    return map;
  }
}
