#!/bin/bash

set -o nounset -o pipefail -o errexit

SCRIPT_DIR=$(readlink -f "$0" | xargs dirname)
ROOT=$(readlink -f "$SCRIPT_DIR/..")
FETCH=$SCRIPT_DIR/fetch

SKIP_BUILD=
while getopts "B-" OPT; do
    case $OPT in
        B) SKIP_BUILD=1 ;;
        -) break ;;
        ?) exit 2 ;;
    esac
done
shift $((OPTIND-1))

CURRENT=$(<"$ROOT/version")
LATEST=$(gh release list --exclude-pre-releases --repo neovim/neovim --json tagName --jq 'map(.tagName) | map(select(. != "stable")) | .[0]')
LATEST=${LATEST/#v}

echo 1>&2 "current version: $CURRENT"
echo 1>&2 "latest version: $LATEST"

if [ "$CURRENT" == "$LATEST" ]; then
    exit 0
fi

if [ -z "${WORKDIR-}" ]; then
    WORKDIR=$(mktemp -d)
    trap 'rm -rf $WORKDIR' EXIT
else
    mkdir -p "$WORKDIR"
fi
WORKDIR=$(readlink -f "$WORKDIR")
export WORKDIR
cd "$WORKDIR"

URL="https://github.com/neovim/neovim/archive/refs/tags/v$LATEST.tar.gz"
TARBALL="nvim-v$LATEST.tar.gz"

echo 1>&2 "fetching: $URL"
$FETCH --root="$WORKDIR" --manifest-filename="$SCRIPT_DIR/nvim.json" add "$URL" "$TARBALL"

if [ -z "$SKIP_BUILD" ]; then
    echo 1>&2 "installing: $LATEST"
    "$SCRIPT_DIR/install.sh" -v "$LATEST"
fi

echo 1>&2 "set current version: v$LATEST"
echo "$LATEST" >"$ROOT/version"

if [ -n "$SKIP_BUILD" ]; then
    exit 1
fi
