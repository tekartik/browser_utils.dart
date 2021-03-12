import 'dart:html';

import 'package:tekartik_browser_utils/src/location_info_utils.dart';
import 'src/location_info_common_utils.dart';

LocationInfo? _locationInfo;

LocationInfo? get locationInfo =>
    _locationInfo ??
    () {
      _locationInfo = BrowserLocationInfo(window.location);
      return _locationInfo;
    }();
