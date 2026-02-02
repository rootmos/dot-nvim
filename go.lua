print("hello")

require("preserve_env")

--vim.uv.spawn("./inner.sh", { env = { FOO = "works" }, text = true }, function(a,b)
    --print(a, b)
--end)

vim.system({"./inner.sh"}, { env = { FOO = "works" } }):wait()

print("bye")

vim.system({"sleep", "1"}):wait()
