local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.add_snippets("", {
    s("bash", {
        t{"#!/bin/bash", "", "set -o nounset -o pipefail -o errexit", "", ""},
    }),
})

ls.add_snippets("sh", {
    s("bash", {
        t{"#!/bin/bash", "", "set -o nounset -o pipefail -o errexit", "", ""},
    }),
    s("xtrace", {
        t{"set -o xtrace"},
    }),
    s("mktemp", {
        t{"TMP=$(mktemp -d)", "trap 'rm -rf $TMP' EXIT", "", ""},
    }),
    s("SCRIPT_DIR", {
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
    s("echo", {
        t{"echo 1>&2 \""}, i(0), t{"\""},
    }),
    s("mapfile", {
        t{"mapfile -t "}, i(1), t{" < <("}, i(2), t{")", ""},
    }),
})

ls.add_snippets("make", {
    s("CURRENT_DIR", {
        t{"CURRENT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))", ""},
    }),
    s(".PHONY", {
        t{".PHONY: "}, i(1), t{"", ""},
        rep(1), t{":", ""},
        t{"	"}, i(0),
    }),
})

ls.add_snippets("python", {
    s("script_dir", {
        t{"script_dir = os.path.dirname(os.path.realpath(__file__))", ""},
    }),
    s("now", {
        t{"datetime.datetime.now(datetime.UTC)"},
    }),
    s("iso8601", {
        t{'isoformat(timespec="seconds")'},
    }),
})

do
    ls.add_snippets("mail", {
        s("Hej", {
            c(1, {
                sn(1, {t{"Hej "}, i(1), t{",", ""}}),
                sn(1, {t{"Hej igen "}, i(1), t{",", "", ""}}),
                t{"Hej,", "", ""},
                t{},
            }),
            t{""},
            i(0), t{"", "", ""},
            c(2, {
                t{"Vänliga hälsningar,", "Gustav Behm"},
                t{"Vänliga hälsningar,", "Gustav"},
                t{"/Gustav"},
                t{"/G"},
            }),
        }),
    })

    local function kind_regards(i)
        return c(i, {
            t{"Kind regards,", "Gustav Behm"},
            t{"Kind regards,", "Gustav"},
            t{"/Gustav"},
            t{"/G"},
        })
    end

    ls.add_snippets("mail", {
        s("Hello", {
            c(1, {
                sn(1, {t{"Hello "}, i(1), t{",", ""}}),
                sn(1, {t{"Hello again "}, i(1), t{",", "", ""}}),
                t{"Hello,", "", ""},
                t{},
            }),
            t{""},
            i(0), t{"", "", ""},
            kind_regards(2),
        }),
    })

    ls.add_snippets("mail", {
        s("Hi", {
            c(1, {
                sn(1, {t{"Hi "}, i(1), t{",", ""}}),
                sn(1, {t{"Hi again "}, i(1), t{",", "", ""}}),
                t{"Hi,", "", ""},
                t{},
            }),
            t{""},
            i(0), t{"", "", ""},
            kind_regards(2),
        }),
    })
end

ls.add_snippets("go", {
    s("go", {
        t{"go func() {", ""},
        t{"\t"}, i(1), t{"", ""},
        t{"}()"},
    }),
    s("defer", {
        t{"defer func() {", ""},
        t{"\t"}, i(1), t{"", ""},
        t{"}()"},
    }),
})
