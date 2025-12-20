return {
  -- NERDTree
  {
    "preservim/nerdtree",
    cmd = "NERDTreeToggle",
    dependencies = { "ryanoasis/vim-devicons" },
    config = function()
      vim.g.nerdtree_tabs_autoclose = 0
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDDefaultAlign = 'left'
      vim.g.NERDTreeDirArrowExpandable = '▸'
      vim.g.NERDTreeDirArrowCollapsible = '▾'
      vim.g.NERDTreeChDirMode = 2
      vim.g.NERDTreeIgnore = { '\\.rbc$', '\\~$', '\\.pyc$', '\\.db$', '\\.sqlite$', '__pycache__' }
      vim.g.NERDTreeSortOrder = { '^__\\.py$', '\\/$', '*', '\\.swp$', '\\.bak$', '\\~$' }
      vim.g.nerdtree_tabs_focus_on_files = 1
      vim.g.NERDTreeWinSize = 25
      vim.api.nvim_set_keymap('n', '<F9>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-symbols.nvim", 
    },
    config = function()
        require("telescope").setup {
            defaults = {
                layout_strategy = "vertical",
                layout_config = { height = 0.75, width = 0.9 },
                file_ignore_patterns = { "node_modules", "build", "gradle", "bin", "out", ".env" }
            }
        }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<C-k>', builtin.keymaps, {})
    end
  },

  -- Tmux navigator
  "christoomey/vim-tmux-navigator",
}
