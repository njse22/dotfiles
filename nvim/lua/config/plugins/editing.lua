------------------------
--  UltiSnips Config  --
------------------------
vim.g.snips_author = "Nicolas J. Salazar E. (njse22)"

vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
vim.g.UltiSnipsEditSplit = "vertical"

-----------------------
--  Fugitive Config  --
-----------------------
vim.api.nvim_set_keymap('n', '<Leader>ga', ':Gwrite<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gc', ':Gcommit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gsh', ':Gpush<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gll', ':Gpull<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gs', ':Gstatus<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gb', ':Gblame<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gd', ':Gvdiff<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gr', ':Gremove<CR>', { noremap = true, silent = true })


