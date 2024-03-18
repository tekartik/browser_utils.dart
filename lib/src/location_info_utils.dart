import 'package:tekartik_browser_utils/src/location_info_common_utils.dart';
import 'package:web/web.dart' as web;

class BrowserLocationInfo implements LocationInfo {
  final web.Location _location;
  // never null
  @override
  final Map<String, String> arguments;
  BrowserLocationInfo(this._location)
      : arguments = locationSearchGetArguments(_location.search);

  @override
  String get host => _location.host;

  @override
  String? get path => _location.pathname;

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
    loc['protocol'] = _location.protocol;
    loc['pathname'] = _location.pathname;
    loc['search'] = _location.search;
    loc['href'] = _location.href;
    loc['hostname'] = _location.hostname;
    loc['port'] = _location.port;
    loc['origin'] = _location.origin;
    loc['host'] = _location.host;
    map['location'] = loc;
    return map;
  }
}
