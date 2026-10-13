class MockLocationInfo implements LocationInfo {
  @override
  Map<String, String> arguments = {};
  @override
  String? host;
  @override
  String? path;
}

abstract class LocationInfo {
  String? get host;

  String? get path;

  Map<String, String> get arguments;
}

/// The arguments of a query, typically `window.location.search`, never null.
///
/// It also accepts a query without the leading `?` and a full uri (its path
/// and fragment are ignored). A repeated key keeps its last value. A
/// malformed escape (such as a raw `%`) never throws: the raw text is kept.
Map<String, String> locationSearchGetArguments(String? search) {
  if (search == null) {
    return <String, String>{};
  }
  // A fragment always starts at the first '#'.
  var fragmentIndex = search.indexOf('#');
  if (fragmentIndex != -1) {
    search = search.substring(0, fragmentIndex);
  }
  // Strip what comes before the query ('', or the path of a full uri), but
  // not a '?' inside a value of a query given without its leading '?'.
  final questionMarkIndex = search.indexOf('?');
  if (questionMarkIndex != -1 &&
      !search.substring(0, questionMarkIndex).contains('=')) {
    search = search.substring(questionMarkIndex + 1);
  }
  return _splitQueryString(search);
}

/// [Uri.splitQueryString], decoding leniently on a malformed escape.
Map<String, String> _splitQueryString(String query) {
  try {
    return Uri.splitQueryString(query);
  } catch (_) {
    // ArgumentError (malformed escape) or FormatException (invalid utf8).
    final params = <String, String>{};
    for (var part in query.split('&')) {
      if (part.isEmpty) {
        continue;
      }
      var equalIndex = part.indexOf('=');
      var key = equalIndex == -1 ? part : part.substring(0, equalIndex);
      var value = equalIndex == -1 ? '' : part.substring(equalIndex + 1);
      params[_decodeQueryComponent(key)] = _decodeQueryComponent(value);
    }
    return params;
  }
}

/// [Uri.decodeQueryComponent], the raw text (with '+' as a space) on a
/// malformed escape.
String _decodeQueryComponent(String component) {
  try {
    return Uri.decodeQueryComponent(component);
  } catch (_) {
    return component.replaceAll('+', ' ');
  }
}
