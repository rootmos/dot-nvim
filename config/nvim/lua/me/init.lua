DOT_NVIM_ME = os.getenv("DOT_NVIM_ME")
if not DOT_NVIM_ME then
    return require("me.actual")
end

if DOT_NVIM_ME == "" then
    return {
        name = { "Alan", "Smithee", },
        homepage = {
            "https://www.imdb.com/name/nm0000647/",
        },
    }
end

return dofile(DOT_NVIM_ME)
