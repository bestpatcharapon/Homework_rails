#!/usr/bin/env bash
# exit on error
set -o errexit

# Force fresh dependency resolution
rm -f Gemfile.lock
export BUNDLE_DEPLOYMENT=0
bundle install
./bin/rails assets:precompile
