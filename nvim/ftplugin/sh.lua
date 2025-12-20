-- Google Style : https://google.github.io/styleguide/shellguide.html
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

vim.keymap.set("n", "<leader>x", function()
  vim.cmd("w")
  local file = vim.fn.expand("%")
  vim.cmd("!chmod +x " .. file)
end, { buffer = true, desc = "Add execute permisions (chmod +x)" })

vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  vim.cmd("!./%") 
end, { buffer = true, desc = "Run Script" })
