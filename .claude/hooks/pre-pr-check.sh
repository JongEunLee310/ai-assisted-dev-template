#!/usr/bin/env bash
set -euo pipefail

echo "pre-pr-check: running build and tests..."

if [ -f "./gradlew" ]; then
  ./gradlew build
elif [ -f "./mvnw" ]; then
  ./mvnw verify
else
  echo "pre-pr-check: no build tool wrapper found."
  exit 1
fi

echo "pre-pr-check: passed."
exit 0
