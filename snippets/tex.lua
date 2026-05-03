return {
    s("document", {
        t{"\\documentclass{rootmos}", ""},
        t{"", ""},
        t{"\\begin{document}", ""},
        i(1), t{"", ""},
        t{"\\end{document}"},
    }),
    s("begin", {
        t{"\\begin{"}, i(1), t{"}", ""},
        t{"    "}, i(2), t{"", ""},
        t{"\\end{"}, rep(1), t{"}"},
    }),
    s("itemize", {
        t{"\\begin{itemize}", ""},
        t{"    \\item "}, i(1), t{"", ""},
        t{"\\end{itemize}", ""},
    }),
}
