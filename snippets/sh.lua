return {
    s("xtrace", {
        t{"set -o xtrace"},
    }),
    s("mktemp", {
        t{"TMP=$(mktemp -d)", "trap 'rm -rf $TMP' EXIT", "", ""},
    }),
    s("SCRIPT_DIR=", {
        t{'SCRIPT_DIR=$(readlink -f "$0" | xargs dirname)', ""},
    }),
    s("getopts", {
        t('while getopts "'), i(1), t{'-" OPT; do', ""},
        t{"    case $OPT in", ""},
        t("        "), i(2), t{"", ""},
        t{"        -) break ;;", ""},
        t{"        ?) exit 2 ;;", ""},
        t{"    esac", ""},
        t{"done", ""},
        t{"shift $((OPTIND-1))", ""},
    }),
    s("getopts-usage", {
        t('while getopts "'), i(1), t{'h-" OPT; do', ""},
        t{"    case $OPT in", ""},
        t("        "), i(2), t{"", ""},
        t{"        -) break ;;", ""},
        t{"        h) usage ;;", ""},
        t{"        ?) usage 2 ;;", ""},
        t{"    esac", ""},
        t{"done", ""},
        t{"shift $((OPTIND-1))", ""},
    }),
    s("usage", {
        t{"usage() {", ""},
        t{"    cat <<EOF 1>&2", ""},
        t{'Usage: $(basename "$0") [options]', ""},
        t{"Options:", ""},
        t{"    -h          show this message", ""},
        t{"EOF", ""},
        t{'    exit "${1-0}"', ""},
        t{"}", ""},
    }),
    s("WORKDIR", {
        t{'if [ -z "${WORKDIR-}" ]; then', ''},
        t{'    WORKDIR=$(mktemp -d)', ''},
        t{"    trap 'rm -rf $WORKDIR' EXIT", ''},
        t{'else', ''},
        t{'    mkdir -p "$WORKDIR"', ''},
        t{'fi', ''},
        t{'WORKDIR=$(readlink -f "$WORKDIR")', ''},
        t{'cd "$WORKDIR"', ''},
    }),
    s("eecho", {
        t{"echo 1>&2 \""}, i(0), t{"\""},
    }),
    s("mapfile", {
        t{"mapfile -t "}, i(1), t{" < <("}, i(2), t{")", ""},
    }),
    s("if-z", {
        t{'if [ -z "${'}, i(1), t{'-}" ]; then', ""},
        t{'    '}, i(0), t{"", ""},
        t{"fi"},
    }),
    s("if-n", {
        t{'if [ -n "${'}, i(1), t{'-}" ]; then', ""},
        t{'    '}, i(0), t{"", ""},
        t{"fi"},
    }),
}
