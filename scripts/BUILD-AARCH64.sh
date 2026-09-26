#!/usr/bin/env bash
set -euo pipefail

ROOT="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
BUILD="$ROOT/build/aarch64"
FRAMEWORK="$ROOT/third_party/nextos-framework"

: "${AARCH64_CC:=aarch64-linux-gnu-gcc}"
: "${AARCH64_CXX:=aarch64-linux-gnu-g++}"

if [[ ! -d "$FRAMEWORK" ]]; then
  echo "NextOS framework missing: $FRAMEWORK" >&2
  echo "Run the GitHub Actions workflow or clone nextos-framework into third_party/." >&2
  exit 2
fi

mkdir -p "$BUILD"

case "${1:-build}" in
  configure)
    cmake -S "$ROOT" -B "$BUILD" -G Ninja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_C_COMPILER="$AARCH64_CC" \
      -DCMAKE_CXX_COMPILER="$AARCH64_CXX" \
      -DCMAKE_SYSTEM_NAME=Linux \
      -DCMAKE_SYSTEM_PROCESSOR=aarch64
    ;;
  build)
    cmake -S "$ROOT" -B "$BUILD" -G Ninja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_C_COMPILER="$AARCH64_CC" \
      -DCMAKE_CXX_COMPILER="$AARCH64_CXX" \
      -DCMAKE_SYSTEM_NAME=Linux \
      -DCMAKE_SYSTEM_PROCESSOR=aarch64
    cmake --build "$BUILD" --parallel
    ;;
  clean)
    rm -rf "$BUILD"
    ;;
  *)
    echo "Usage: $0 {configure|build|clean}" >&2
    exit 2
    ;;
esac
