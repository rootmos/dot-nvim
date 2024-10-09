#!/bin/bash

set -o nounset -o pipefail -o errexit

SCRIPT_DIR=$(readlink -f "$0" | xargs dirname)
ROOT=$(readlink -f "$SCRIPT_DIR/..")
FETCH=$SCRIPT_DIR/fetch

VERSION=0.10.2
while getopts "v:w:-" OPT; do
    case $OPT in
        v) VERSION=$OPTARG ;;
        w) WORKDIR=$OPTARG ;;
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

TARBALL=nvim-$VERSION.tar.gz
$FETCH --manifest-filename="$SCRIPT_DIR/nvim.json" download "$TARBALL" >/dev/null

tar xf "$TARBALL"

TARGET=${1-${TARGET-$ROOT/root/v$VERSION}}

cd "neovim-$VERSION"
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$TARGET"
make install
