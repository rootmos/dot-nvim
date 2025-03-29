return {
    s("CURRENT_DIR :=", {
        t{"CURRENT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))", ""},
    }),
    s(".PHONY", {
        t{".PHONY: "}, i(1), t{"", ""},
        rep(1), t{":", ""},
        t{"	"}, i(0),
    }),
}
