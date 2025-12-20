return {
  -- Themes
  "ayu-theme/ayu-vim",
  "pineapplegiant/spaceduck",
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine" },

  -- Status line
  {
    "vim-airline/vim-airline",
    config = function()
        vim.g['airline#extensions#tabline#enabled'] = 1
        vim.g.airline_powerline_fonts = 1
        vim.cmd([[colorscheme catppuccin-mocha]])
    end
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"}, -- It uses icons
    config = function()
        local headers = require "headers.headers"
        local utils = require('utils.utils')
        require('dashboard').setup {
            theme = 'doom',
            config = {
                header = headers.skull,
                center = {
                    { icon = ' ', icon_hl = 'Title', desc = 'New File            ', desc_hl = 'String', key = 'e', keymap = '', key_hl = 'Number', key_format = ' %s', action = 'enew | startinsert' },
                    { icon = '󰉋 ', icon_hl = 'Title', desc = 'Create Directory ', desc_hl = 'String', key = 'mk', keymap = '', key_hl = 'Number', key_format = ' %s', action = utils.create_new_dir },
                    { icon = '󰙅 ', icon_hl = 'Title', desc = 'Toggle File Explorer', desc_hl = 'String', key = 'ee', keymap = '', key_hl = 'Number', key_format = ' %s', action = 'NERDTreeToggle' },
                    { icon = '󰱼 ', icon_hl = 'Title', desc = 'Find File           ', desc_hl = 'String', key = 'fp', keymap = '', key_hl = 'Number', key_format = ' %s', action = 'Telescope find_files' },
                    { icon = ' ', icon_hl = 'Title', desc = 'View Autocommands           ', desc_hl = 'String', key = 'fc', keymap = '', key_hl = 'Number', key_format = ' %s', action = 'Telescope autocommands' },
                    { icon = '󰌁 ', icon_hl = 'Title', desc = 'Set Colorschema           ', desc_hl = 'String', key = 'ft', keymap = '', key_hl = 'Number', key_format = ' %s', action = 'Telescope colorscheme' },
                    { icon = ' ', icon_hl = 'Title', desc = 'Open Nvim config           ', desc_hl = 'String', key = 'vc', keymap = '', key_hl = 'Number', key_format = ' %s', action = 'e ~/.config/nvim/init.lua' },
                    { icon = '󰅙 ', icon_hl = 'Title', desc = 'Quit Nvim            ', desc_hl = 'String', key = 'q', keymap = '', key_hl = 'Number', key_format = ' %s', action = 'q ' },
                },
                footer = {},
                vertical_center = false,
            }
        }
    end
  },

  -- Better UI for vim.ui.select and vim.ui.input
  "stevearc/dressing.nvim",
}
