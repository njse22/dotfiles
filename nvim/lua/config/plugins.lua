-----------------------
--  NERDTree config  --
-----------------------
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

-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   command = "NERDTree"
-- })

------------------------
--  UltiSnips Config  --
------------------------
vim.g.snips_author = "Nicolas J. Salazar E."

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

------------------------
--  Telescope Config  --
------------------------
-- Función para crear archivos con Telescope
local create_file = function(prompt_bufnr)
  local action_state = require('telescope.actions.state')
  local actions = require('telescope.actions')

  -- Obtén el directorio de trabajo actual
  local cwd = vim.fn.getcwd()

  actions.close(prompt_bufnr)  -- Cierra el buffer de Telescope
  
  -- Solicita el nombre del archivo
  local new_file = vim.fn.input("New file: ", cwd .. "/")
  
  -- Si se proporciona un nombre de archivo, lo abre en una nueva ventana
  if new_file and new_file ~= "" then
    -- Crear directorios si no existen
    local mkdir_cmd = 'mkdir -p ' .. vim.fn.fnamemodify(new_file, ':h')
    os.execute(mkdir_cmd)
    
    -- Abrir el nuevo archivo
    vim.cmd("edit " .. new_file)
  end
end

require("telescope").setup {
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            height = 0.75,
            width = 0.9
          },
	  file_ignore_patterns = { 
	      "node_modules", 
	      "build", 
	      "gradle", 

	      "bin", 
	      "out", 
	      ".env"
	    }
     }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<C-h>', builtin.keymaps, {})

----------------------------------------------
--  Theme and User Interface configuration  --
----------------------------------------------

-- vim.o.background = "dark"
vim.cmd([[colorscheme catppuccin-mocha]])

vim.g['airline#extensions#tabline#enabled'] = 1
vim.g.airline_powerline_fonts = 1

-----------------
--  Dashboard  --
-----------------

local headers = require "headers.headers"
local utils = require('utils.utils')


require('dashboard').setup {
    theme = 'doom',
    config = {

	header = headers.skull,

	center = {
	    {
		icon = ' ',
		icon_hl = 'Title',
		desc = 'New File            ',
		desc_hl = 'String',
		key = 'e',
		keymap = '',
		key_hl = 'Number',
		key_format = ' %s', 
		action = 'enew | startinsert'
	    },

	    {
		icon = '󰉋 ',
		icon_hl = 'Title',
		desc = 'Create Directory ',
		desc_hl = 'String',
		key = 'mk',
		keymap = '',
		key_hl = 'Number',
		key_format = ' %s', 
		action = utils.create_new_dir
	    },

	    {
		icon = '󰙅 ',
		icon_hl = 'Title',
		desc = 'Toggle File Explorer',
		desc_hl = 'String',
		key = 'ee',
		keymap = '',
		key_hl = 'Number',
		key_format = ' %s', 
		action = 'NERDTreeToggle'
	    },

	    {
		icon = '󰱼 ',
		icon_hl = 'Title',
		desc = 'Find File           ',
		desc_hl = 'String',
		key = 'fp',
		keymap = '',
		key_hl = 'Number',
		key_format = ' %s', 
		action = 'Telescope find_files'
	    },

	    {
		icon = ' ',
		icon_hl = 'Title',
		desc = 'View Autocommands           ',
		desc_hl = 'String',
		key = 'fc',
		keymap = '',
		key_hl = 'Number',
		key_format = ' %s', 	
		action = 'Telescope autocommands'
	    },

	    {
		icon = '󰌁 ',
		icon_hl = 'Title',
		desc = 'Set Colorschema           ',
		desc_hl = 'String',
		key = 'ft',
		keymap = '',
		key_hl = 'Number',
		key_format = ' %s', 
		action = 'Telescope colorscheme'
	    },

	    {
		icon = ' ',
		icon_hl = 'Title',
		desc = 'Open Nvim config           ',
		desc_hl = 'String',
		key = 'vc',
		keymap = '',
		key_hl = 'Number',
		key_format = ' %s', 
		action = 'e ~/.config/nvim/init.lua'
	    },

	    {
		icon = '󰅙 ',
		icon_hl = 'Title',
		desc = 'Quit Nvim            ',
		desc_hl = 'String',
		key = 'q',
		keymap = '',
		key_hl = 'Number',
		key_format = ' %s', 
		action = 'q '
	    },

    },
    footer = {},
    vertical_center = false, -- Center the Dashboard on the vertical (from top to bottom)
    }
}

