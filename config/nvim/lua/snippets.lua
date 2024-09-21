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

ls.add_snippets("sh", {
    s("bash", {
        t{"#!/bin/bash", "", "set -o nounset -o pipefail -o errexit", "", ""},
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
})

ls.add_snippets("make", {
    s("CURRENT_DIR", {
        t{"CURRENT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))", ""},
    }),
})
