class MockLocationInfo implements LocationInfo {
  @override
  Map<String, String> arguments = {};
  @override
  String host;
  @override
  String path;
}

abstract class LocationInfo {
  String get host;

  String get path;

  Map<String, String> get arguments;
}

/**
 * Typically the argument is window.location.search
 * never null
 */
Map<String, String> locationSearchGetArguments(String search) {
  Map<String, String> params = new Map();
  if (search != null) {
    int questionMarkIndex = search.indexOf('?');
    if (questionMarkIndex != -1) {
      search = search.substring(questionMarkIndex + 1);
    }
    return Uri.splitQueryString(search);
  }
  return params;
}
