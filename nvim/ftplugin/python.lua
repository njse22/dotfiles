-- (PEP 8 )
vim.opt_local.expandtab = true    -- Convertir tabs a espacios
vim.opt_local.shiftwidth = 4      -- Tamaño de indentación automática
vim.opt_local.tabstop = 4         -- Tamaño visual del tab
vim.opt_local.softtabstop = 4     -- Tamaño al borrar

vim.opt_local.colorcolumn = "88"

vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  vim.cmd("!python3 %")
end, { buffer = true, desc = "Run Python Script" })
