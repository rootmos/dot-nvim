local P = {}

local function add(p)
    p.ft = "haskell"
    table.insert(P, p)
end

add {
    "neovimhaskell/haskell-vim"
}

add {
    "mrcjkb/haskell-tools.nvim",
    version = "*",
    lazy = true,
}

add {
    "luc-tielen/telescope_hoogle",
}

return P
