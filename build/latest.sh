#!/bin/bash

set -o nounset -o pipefail -o errexit

SCRIPT_DIR=$(readlink -f "$0" | xargs dirname)
ROOT=$(readlink -f "$SCRIPT_DIR/..")
FETCH=$SCRIPT_DIR/fetch

CURRENT=$(<"$ROOT/version")
LATEST=$(gh release list --exclude-pre-releases --repo neovim/neovim --json tagName --jq 'map(.tagName) | map(select(. != "stable")) | .[0]')

echo 1>&2 "current version: $CURRENT"
echo 1>&2 "latest version: $LATEST"

if [ -z "${WORKDIR-}" ]; then
    WORKDIR=$(mktemp -d)
    trap 'rm -rf $WORKDIR' EXIT
else
    mkdir -p "$WORKDIR"
fi
export WORKDIR=$(readlink -f "$WORKDIR")
cd "$WORKDIR"

if [ "$CURRENT" != "$LATEST" ]; then
    URL="https://github.com/neovim/neovim/archive/refs/tags/$LATEST.tar.gz"
    TARBALL="nvim-$LATEST.tar.gz"

    echo 1>&2 "fetching: $URL"
    $FETCH --root="$WORKDIR" --manifest-filename="$SCRIPT_DIR/nvim.json" add "$URL" "$TARBALL"

    echo 1>&2 "installing: $LATEST"
    "$SCRIPT_DIR/install.sh" -v "$LATEST"

    echo 1>&2 "set current version: $LATEST"
    echo "$LATEST" >"$ROOT/version"
fi
