import 'package:web/web.dart' as web;

void openInNewTab(Uri uri) {
  web.window.open(uri.toString(), '_blank');
}

void openInNewWindow(Uri uri, {int? width, int? height}) {
  web.window.open(
    uri.toString(),
    '_blank',
    'location=yes${width != null ? ',width=$width' : ''}${height != null ? ',height=$height' : ''}',
  );
  // add more paramerter to options like 'location=yes,height=570,width=520,scrollbars=yes,status=yes');
}

void openInSameTab(Uri uri) {
  web.window.open(uri.toString(), '_self');
}

void reload({Uri? uri}) {
  locationReload(web.window.location, uri: uri);
}

/// Reload [location], navigating to [uri] (resolved against the current
/// location) if set.
///
/// A reload right after a navigation to another document cancels that
/// navigation, so only a uri changing nothing but the fragment (which does
/// not load the page) is followed by a reload.
void locationReload(web.Location location, {Uri? uri}) {
  if (uri == null) {
    location.reload();
    return;
  }
  var current = Uri.parse(location.href);
  var target = current.resolveUri(uri);
  location.replace(target.toString());
  if (target.removeFragment() == current.removeFragment()) {
    location.reload();
  }
}
