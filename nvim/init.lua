--     _   __         _    __
--    / | / /__  ____| |  / (_)___ ___
--   /  |/ / _ \/ __ \ | / / / __ `__ \
--  / /|  /  __/ /_/ / |/ / / / / / / /
-- /_/ |_/\___/\____/|___/_/_/ /_/ /_/

----------------------------
--  Configurations files  --
----------------------------

require("config.general")

local Plug = vim.fn['plug#']

--------------------
--  Load Plugins  --
--------------------

vim.call('plug#begin')

-- User Interface | Themes 
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/everforest'
Plug 'pineapplegiant/spaceduck'
Plug 'catppuccin/nvim'
Plug "rose-pine/neovim"

Plug 'vim-airline/vim-airline'     -- graphical interface
Plug 'nvimdev/dashboard-nvim'

-- IDE
Plug('junegunn/fzf', { ['do'] = function()
  vim.fn['fzf#install']()
end })

Plug('preservim/nerdtree', { ['on'] = 'NERDTreeToggle' })
Plug('ryanoasis/vim-devicons')
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'tpope/vim-fugitive'     -- to use Git in vim
Plug 'tpope/vim-rhubarb'      -- required by fugitive to :Gbrowse for open de file proyect in github
Plug 'Raimondi/delimitMate'   -- autocompletion in insert mode
Plug 'junegunn/vim-easy-align'

-- Telescope file finder / picker, two above it are dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'majutsushi/tagbar'           -- a tool to navigate in code with tags
Plug 'christoomey/vim-tmux-navigator'

Plug 'krcs/vim-routeros-syntax'
-- Project management
Plug 'nvim-telescope/telescope-project.nvim'

-- LaTex 
Plug 'artisticat1/obsidian-latex-suite'
Plug 'lervag/vimtex'

-- LSP 
-- Plug 'williamboman/mason.nvim'
-- Plug "williamboman/mason-lspconfig.nvim"
-- Plug 'neovim/nvim-lspconfig'

-- nvim cmp 
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

-- Springboot 
Plug "javiorfo/nvim-popcorn"
Plug "javiorfo/nvim-spinetta"
Plug "hrsh7th/nvim-cmp"
Plug 'javiorfo/nvim-springtime'

-- gradle 
Plug "nvim-lua/plenary.nvim"
Plug "MunifTanjim/nui.nvim"
Plug "oclay1st/gradle.nvim"

vim.call('plug#end')

vim.g.mapleader = ','

require("config.plugins")
require("config.coc")

