local snippets = {}

local function add(name, def)
    table.insert(snippets, s(name, def))
end


local function add_greeting_phrase(phrase, again)
    add(phrase, {
        c(1, {
            sn(1, {t{phrase .. " "}, i(1), t{",", ""}}),
            sn(1, {t{phrase .. " " .. again .. " "}, i(1), t{",", "", ""}}),
            t{phrase .. ",", "", ""},
        }),
    })
end

local function add_parting_phrase(phrase)
    local name = me and me.name
    if not name then
        return
    end

    add(phrase, {
        c(1, {
            t{phrase .. ",", name[1] .. " " .. name[2]},
            t{phrase .. ",", name[1]},
            t{"/" .. name[1]},
            t{"/" .. name[1]:sub(1,1)},
        }),
    })
end

add_greeting_phrase("Hej", "igen")
add_parting_phrase("Vänliga hälsningar")

add_greeting_phrase("Hello", "again")
add_greeting_phrase("Hi", "again")
add_parting_phrase("Kind regards")


local function mk_homepage_snippets(homepage)
    local ts = {}
    for _, url in ipairs(homepage) do
        table.insert(ts, t{url, ""})
    end
    table.insert(ts, t{})
    return ts
end

local function mk_social_snippets(social)
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

if me then
    local ts = {
        t{"--", ""},
    }

    if me.homepage then
        table.insert(ts, c(#ts, mk_homepage_snippets(me.homepage)))
    end

    if me.social then
        table.insert(ts, c(#ts, mk_social_snippets(me.social)))
    end

    add("--", ts)
end

return snippets
