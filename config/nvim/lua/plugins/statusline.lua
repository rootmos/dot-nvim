return {
  {
    "vim-airline/vim-airline-themes",
    dependencies = {
      { "vim-airline/vim-airline" },
    },
    config = function()
      vim.api.nvim_set_var("airline_solarized_bg", "dark")
      vim.api.nvim_set_var("airline_theme", "solarized")
    end,
  }
}
