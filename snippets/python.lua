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
    s("logging", {
        t{"import logging", ""},
        t{"logger = logging.getLogger(__name__)"},
    }),
}
