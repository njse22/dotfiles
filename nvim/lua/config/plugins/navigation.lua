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

vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   command = "NERDTree"
-- })

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


local telescope = require("telescope")

vimgrep_arguments = {
    "grep",
    "--color=never",
    "--with-filename",
    "--line-number",
    "-b",
    "--ignore-case",
    "--recursive",
    "--no-messages",
}

telescope.setup({
    defaults = {
	layout_strategy = "horizontal",
	prompt_prefix = "   ",
	layout_config = {
	    horizontal = {
		prompt_position = "bottom",
		preview_width = 0.55,
	    },
	    vertical = {
		mirror = true,
	    },
	    width = 0.85,
	    height = 0.85,
	    preview_cutoff = 120,
	},
	file_ignore_patterns = { 
	    "node_modules", 
	    "build", 
	    "gradle", 
	    "bin", 
	    "out", 
	    ".env" 
	}
    },

    pickers = {
      find_files = { previewer = true },
      buffers = { previewer = true },
      live_grep = {
	  vimgrep_arguments = vimgrep_arguments,
      },
    },
})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('project')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- vim.keymap.set('n', '<C-h>', builtin.keymaps, {})
