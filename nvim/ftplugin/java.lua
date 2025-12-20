vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  vim.cmd("!./gradlew bootRun") 
end, { buffer = true, desc = "Gradle BootRun" })

vim.keymap.set("n", "<leader>rt", function()
  vim.cmd("w")
  vim.cmd("!./gradlew test")
end, { buffer = true, desc = "Gradle Test" })
