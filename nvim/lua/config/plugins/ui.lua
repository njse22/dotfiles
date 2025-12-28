return {
  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
      vim.api.nvim_set_hl(0, "ScopeColor", { fg = "#F38BA8", bold = true })
    end,
  },
  {
    "ayu-theme/ayu-vim",
    name = "ayu-vim",
    config = function()
       vim.g.ayucolor = "mirage"
    end
  },
  { 'pineapplegiant/spaceduck' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'joshdick/onedark.vim' },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
              statusline = {},
              winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
              refresh_time = 16, -- ~60fps
              events = {
              'WinEnter',
              'BufEnter',
              'BufWritePost',
              'SessionLoadPost',
              'FileChangedShellPost',
              'VimResized',
              'Filetype',
              'CursorMoved',
              'CursorMovedI',
              'ModeChanged',
              },
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {
          lualine_a = {
              {
              'buffers',
              mode = 2,
              use_mode_colors = true,
              symbols = {
                  modified = ' ●',
                  alternate_file = '#',
                  directory =  '',
              },
              }
          },
          lualine_z = {'Tabs'}

        },
        winbar = {},
        inactive_winbar = {},
        extensions = {'fzf'}
      }
    end,
  },

  -- Icons
  { "ryanoasis/vim-devicons" }
}
