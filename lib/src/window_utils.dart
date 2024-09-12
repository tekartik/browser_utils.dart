import 'package:web/web.dart' as web;

void openInNewTab(Uri uri) {
  web.window.open(uri.toString(), '_blank');
}

void openInNewWindow(Uri uri, {int? width, int? height}) {
  web.window.open(uri.toString(), '_blank',
      'location=yes${width != null ? ',width=$width' : ''}${height != null ? ',height=$height' : ''}');
// add more paramerter to options like 'location=yes,height=570,width=520,scrollbars=yes,status=yes');
}

void openInSameTab(Uri uri) {
  web.window.open(uri.toString(), '_self');
}
