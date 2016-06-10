#!/bin/bash

# Fast fail the script on failures.
set -e

dartanalyzer --fatal-warnings \
  lib/css_utils.dart \
  lib/js_utils.dart

pub run test -p vm,firefox