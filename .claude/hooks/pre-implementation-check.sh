#!/usr/bin/env bash
set -euo pipefail

echo "pre-implementation-check: verifying Java and build wrapper are available..."

if ! command -v java &>/dev/null; then
  echo "pre-implementation-check: java not found."
  exit 1
fi

if [ ! -f "./gradlew" ] && [ ! -f "./mvnw" ]; then
  echo "pre-implementation-check: neither gradlew nor mvnw found. Run from project root."
  exit 1
fi

echo "pre-implementation-check: passed."
exit 0
