import 'package:tekartik_browser_utils/src/location_info_utils.dart';
import 'package:web/web.dart' as web;

import 'src/location_info_common_utils.dart';

LocationInfo? _locationInfo;

LocationInfo? get locationInfo =>
    _locationInfo ??
    () {
      _locationInfo = BrowserLocationInfo(web.window.location);
      return _locationInfo;
    }();
