#!/bin/bash
# Clone Flutter into a temporary directory
git clone https://github.com/flutter/flutter.git --depth 1 -b stable
export PATH="$PATH:$(pwd)/flutter/bin"

# Disable analytics to speed up
flutter config --no-analytics
flutter config --enable-web

# Recreate web platform files for missing index.html
flutter create --platforms=web .

# Build the project
flutter build web --release
