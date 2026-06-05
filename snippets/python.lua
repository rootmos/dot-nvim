return {
    s("script_dir =", {
        t{"script_dir = os.path.dirname(os.path.realpath(__file__))", ""},
    }),
    s("now", {
        t{"datetime.now(UTC)"},
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
    }),
    s("run", {
        t{"cmdline = ["}, i(2), t{"]", ""},
        t{'logger.debug("running: %s", cmdline)', ""},
        c(1, {
            t{"subprocess.check_call(cmdline)", ""},
            t{"o = subprocess.check_output(cmdline, text=True)", ""},
            t{"ls = subprocess.check_output(cmdline, text=True).splitlines()", ""},
            t{"[l] = subprocess.check_output(cmdline, text=True).splitlines()", ""},
            t{"p = subprocess.run(cmdline, check=False)", ""},
        }),
    }),
}
