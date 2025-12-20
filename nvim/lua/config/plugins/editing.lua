return {
  -- Git
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
        vim.api.nvim_set_keymap('n', '<Leader>ga',   ':Gwrite<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>gc',  ':Gcommit<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>gsh',   ':Gpush<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>gll',   ':Gpull<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>gs',  ':Gstatus<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>gb',   ':Gblame<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>gd',   ':Gvdiff<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<Leader>gr',  ':Gremove<CR>', { noremap = true, silent = true })
    end
  },

  -- Editing
  "Raimondi/delimitMate",
  "junegunn/vim-easy-align",
  "krcs/vim-routeros-syntax",
}
