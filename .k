go() {
    rm -f .env
    ./nvim -l go.lua && ([ -e .env ] && cat .env || true)
}
