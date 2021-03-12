import 'package:process_run/shell.dart';

Future main() async {
  //await packageRunCi('.', noAnalyze: true);
  await run('''
  # NO!: dart analyze --fatal-warnings --fatal-infos .
  dart analyze --fatal-warnings .
  ''');
}
