#!/bin/bash

# Fast fail the script on failures.
set -e

dartanalyzer --fatal-warnings \
  lib/css_utils.dart \
  lib/js_utils.dart \
  lib/browser_utils_import.dart \
  lib/location_info_utils.dart \
  lib/element_utils.dart \
  lib/console_utils.dart \

pub run test -p vm,firefox,chrome