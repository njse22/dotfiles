--     _   __         _    __
--    / | / /__  ____| |  / (_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/
-------------------------------------------------------

-- ====================================================
--  GENERAL CONFIGURATION 
-- ====================================================
vim.g.mapleader = ','

require("config.general")

-- ====================================================
-- P4 SYNTAX CONFIGURATION
-- ====================================================
vim.filetype.add({
  extension = {
    p4 = "p4",
  },
})

-- ====================================================
--  BOOTSTRAP LAZY.NVIM
-- ====================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ====================================================
--  PLUGINS CONFIGURATION
-- ====================================================
require("lazy").setup({

  -- UI
  require("config.plugins.ui"),

  -- Navigation 
  require("config.plugins.navigation"),
  
  -- Edition 
  require("config.plugins.editing"),

  -- Autocompletetion
  require("config.plugins.completion"),

  -- LSP 
  require("config.plugins.lsp"),

  -- Lenguages
  require("config.plugins.languages"),
})
