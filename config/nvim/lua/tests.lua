local test_case = DOT_NVIM_TESTS or ""
if test_case == "sanity-check" then
    error("make sure errors are caught")
elseif test_case:sub(0,3) == "ft:" then
    local ft = test_case:sub(4)

    vim.cmd.enew()
    vim.opt.filetype = ft
end
