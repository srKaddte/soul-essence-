#!/bin/sh
set -eu

PORT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"
GAME_DIR="${PORT_DIR}/gamedata"
BIN="${PORT_DIR}/bin/aarch64/soul-essence-nextos"

export SOUL_ESSENCE_GAME_DIR="${GAME_DIR}"
export SDL_VIDEODRIVER="${SDL_VIDEODRIVER:-kmsdrm}"
export SDL_AUDIODRIVER="${SDL_AUDIODRIVER:-alsa}"

if [ ! -x "$BIN" ]; then
    echo "Soul Essence: native adapter not found: $BIN" >&2
    exit 1
fi

exec "$BIN" "$GAME_DIR" "$@"
