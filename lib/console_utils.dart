import 'package:stack_trace/stack_trace.dart';
import 'package:tekartik_browser_utils/browser_utils_import.dart';

void printError(e, [StackTrace st]) {
  try {
    window.console.error(e);
  } catch (_) {
    print(e);
  }
  if (st != null) {
    try {
      window.console.error(Trace.format(st));
    } catch (_) {
      print(st);
    }
    //devPrint(st);
  }
}
