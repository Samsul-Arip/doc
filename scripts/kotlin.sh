#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p .test-results
if ! command -v kotlinc >/dev/null; then
  echo 'Pasang compiler Kotlin (lihat docs/01-install-tools.md), lalu ulangi.' >&2
  exit 1
fi
# Array glob kompatibel dengan Bash 3 macOS dan Bash Linux.
sources=(kotlin-logic/basics/*.kt kotlin-logic/patterns/Patterns.kt kotlin-logic/algorithms/*.kt kotlin-logic/solutions/*.kt)
if [[ "${1:-}" == "test" ]]; then
  kotlinc "${sources[@]}" kotlin-logic/tests/TestMain.kt -include-runtime -d .test-results/kotlin-tests.jar
  java -jar .test-results/kotlin-tests.jar
else
  kotlinc "${sources[@]}" kotlin-logic/Main.kt -include-runtime -d .test-results/kotlin-app.jar
  java -jar .test-results/kotlin-app.jar "${@}"
fi
