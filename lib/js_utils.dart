library tekartik_browser_utils_js_utils;

export 'js_loader_utils.dart';

bool get _runningAsJavascript => identical(1, 1.0);

@Deprecated('user common_utils')
bool get runningAsJavascript => _runningAsJavascript;

bool get debugRunningAsJavascript => _runningAsJavascript;
