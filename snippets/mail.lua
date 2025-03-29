local snippets = {}

local name, homepage, social = me.name, me.homepage, me.social

local function add(name, def)
    table.insert(snippets, s(name, def))
end

local function mk_greeting_phrase(phrase, again)
    add(phrase, {
        c(1, {
            sn(1, {t{phrase .. " "}, i(1), t{",", ""}}),
            sn(1, {t{phrase .. " " .. again .. " "}, i(1), t{",", "", ""}}),
            t{phrase .. ",", "", ""},
        }),
    })
end

local function mk_parting_phrase(phrase)
    add(phrase, {
        c(1, {
            t{phrase .. ",", name[1] .. " " .. name[2]},
            t{phrase .. ",", name[1]},
            t{"/" .. name[1]},
            t{"/" .. name[1]:sub(1,1)},
        }),
    })
end

mk_greeting_phrase("Hej", "igen")
mk_parting_phrase("Vänliga hälsningar")

mk_greeting_phrase("Hello", "again")
mk_greeting_phrase("Hi", "again")
mk_parting_phrase("Kind regards")


local function mk_homepage_snippets()
    local ts = {}
    for _, url in ipairs(homepage) do
        table.insert(ts, t{url, ""})
    end
    table.insert(ts, t{})
    return ts
end

local function mk_social_snippets()
    local ts = {}
    for i, url in ipairs(social) do
        local T = {}
        for j = 1,i do
            table.insert(T, social[j])
        end
        table.insert(ts, t(T))
    end
    table.insert(ts, t{})
    return ts
end

add("--", {
    t{"--", ""},
    c(1, mk_homepage_snippets()),
    c(2, mk_social_snippets()),
})

return snippets
