#!/bin/bash

set -o nounset -o pipefail -o errexit

SCRIPT_DIR=$(readlink -f "$0" | xargs dirname)
ROOT=$(readlink -f "$SCRIPT_DIR/..")
FETCH=$SCRIPT_DIR/fetch

export FETCH_MANIFEST="$SCRIPT_DIR/spell.json"
URL="https://ftp.nluug.nl/pub/vim/runtime/spell"

TARGET=${TARGET-}
while getopts "t:-" OPT; do
    case $OPT in
        t) TARGET=$OPTARG ;;
        -) break ;;
        ?) exit 2 ;;
    esac
done
shift $((OPTIND-1))

ENCs=("utf-8")
LANGs=("en" "sv")

if [ -z "$TARGET" ]; then
    TARGET=$("$ROOT/nvim" -l - 2>&1 <<EOF | tr -d '\015'
    local dirs = vim.api.nvim_get_runtime_file("spell", true)
    print(dirs[#dirs])
EOF
)
fi

echo 1>&2 "spell: $TARGET"
mkdir -p "$TARGET"

for enc in "${ENCs[@]}"; do
    for lang in "${LANGs[@]}"; do
        for type in spl sug; do
            f="$lang.$enc.$type"
            $FETCH --root="$TARGET" download "$f"
        done
    done
done
