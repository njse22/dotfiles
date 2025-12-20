-- (Go TABS, no spaces)
vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  vim.cmd("!go run .") 
end, { buffer = true, desc = "Go Run" })

-- Requiere 'gomodifytags' installed 
vim.keymap.set("n", "<leader>gj", ":!gomodifytags -file % -struct % -add-tags json<CR>", { buffer = true, desc = "Añadir JSON tags" })
