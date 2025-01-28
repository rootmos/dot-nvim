return {
  {
    "vim-airline/vim-airline-themes",
    dependencies = {
      { "vim-airline/vim-airline" },
    },
    config = function()
      vim.api.nvim_set_var("airline_solarized_bg", "dark")
      vim.api.nvim_set_var("airline_theme", "solarized")

      vim.api.nvim_set_var("airline_section_a",
        vim.fn["airline#section#create_left"]{
          -- https://github.com/vim-airline/vim-airline/blob/7a552f415c48aed33bf7eaa3c50e78504d417913/autoload/airline/init.vim#L251
          -- "mode", "crypt", "paste", "keymap", "spell", "capslock", "xkblayout", "iminsert",
          "mode", "crypt", "paste", "keymap", "capslock", "xkblayout", "iminsert",
        }
      )
    end,
  }
}
