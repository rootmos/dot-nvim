return {
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
}
