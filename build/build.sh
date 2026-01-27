#!/bin/bash

set -o nounset -o pipefail -o errexit

SCRIPT_DIR=$(readlink -f "$0" | xargs dirname)
ROOT=$(readlink -f "$SCRIPT_DIR/..")
FETCH=$SCRIPT_DIR/fetch

VERSION="$(<"$ROOT/version")"
FORCE=
while getopts "v:w:f-" OPT; do
    case $OPT in
        v) VERSION=$OPTARG ;;
        w) WORKDIR=$OPTARG ;;
        f) FORCE=1 ;;
        -) break ;;
        ?) exit 2 ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${WORKDIR-}" ]; then
    WORKDIR=$(mktemp -d)
    trap 'rm -rf $WORKDIR' EXIT
else
    mkdir -p "$WORKDIR"
fi
WORKDIR=$(readlink -f "$WORKDIR")
cd "$WORKDIR"

TARGET=${1-${TARGET-$ROOT/root/$VERSION}}
if [ -e "$TARGET" ]; then
    if [ -n "${FORCE-}" ]; then
        rm -rf "$TARGET"
    else
        echo 1>&2 "target exists already: $TARGET"
        exit 0
    fi
fi

TARBALL=nvim-v$VERSION.tar.gz
$FETCH --manifest-filename="$SCRIPT_DIR/nvim.json" download "$TARBALL" >/dev/null

tar xf "$TARBALL"

TARGET=${1-${TARGET-$ROOT/root/$VERSION}}

cd "neovim-"*
make -j"$(nproc)" \
    CMAKE_BUILD_TYPE=Release \
    CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$TARGET"
make install
