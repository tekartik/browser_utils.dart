import 'location_info_utils.dart';

/// Convenient arguments option
class ArgumentsOption {
  final String name;

  ArgumentsOption(this.name);

  /// True if contains, false if "no-xxx" is contains, null otherwier
  bool? has() {
    if (locationInfo!.arguments.containsKey('$name')) {
      return true;
    }
    if (locationInfo!.arguments.containsKey('no-$name')) {
      return false;
    }
    return null;
  }
}
