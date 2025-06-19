return {
    s("script_dir =", {
        t{"script_dir = os.path.dirname(os.path.realpath(__file__))", ""},
    }),
    s("now", {
        t{"datetime.now(datetime.UTC)"},
    }),
    s("iso8601", {
        t{'isoformat(timespec="seconds")'},
    }),
    s("utf8", {
        t{'encode("UTF-8")'},
    }),
    s("logging", {
        t{"import logging", ""},
        t{"logger = logging.getLogger(__name__)"},
    }),
    s("open", {
        t{"with open("}, i(1), t{', "'}, i(2), t{'", encoding="UTF-8") as f:', ""},
        t{"    "}, i(3),
    })
}
