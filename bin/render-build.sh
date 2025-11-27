#!/usr/bin/env bash
# exit on error
set -o errexit

# Force fresh dependency resolution
rm -f Gemfile.lock
bundle install
./bin/rails assets:precompile
