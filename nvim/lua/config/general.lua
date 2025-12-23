-- Habilitar números en el editor
vim.opt.number = true

-- Cambiar el ancho de los números
vim.opt.numberwidth = 4

-- Mostrar el comando que estás escribiendo
vim.opt.showcmd = true

-- Cambiar la codificación a UTF-8
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8"

-- Mejorar la velocidad de actualización del terminal
vim.opt.ttyfast = true

-- Arreglar la indentación con la tecla de retroceso
vim.opt.backspace = { "indent", "eol", "start" }

-- Habilitar el portapapeles del sistema operativo
-- vim.opt.clipboard = "unnamed"
vim.opt.clipboard = "unnamedplus"

-- Espaciado de indentación
vim.opt.shiftwidth = 4

-- Indentar 2 espacios cuando se presiona Tab
vim.opt.softtabstop = 2

-- Resaltar coincidencias de paréntesis y corchetes
vim.opt.showmatch = true

-- Mostrar números relativos
vim.opt.relativenumber = true

-- Mostrar la barra de estado
vim.opt.laststatus = 2

-- Mostrar el menú de autocompletado al usar tabulador
vim.opt.wildmenu = true

-- Resaltar la línea actual
vim.opt.cursorline = true

-- Habilitar el resaltado de búsqueda
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Ignorar mayúsculas en la búsqueda
vim.opt.ignorecase = true

-- Usar mayúsculas si hay una en la búsqueda
vim.opt.smartcase = true

-- Habilitar autoindentación
vim.opt.autoindent = true

-- Verificar las configuraciones locales en los archivos
vim.opt.modeline = true
vim.opt.modelines = 3

-- Quitar el texto del modo actual
vim.opt.showmode = false

-- Resaltar la columna 85
vim.opt.colorcolumn = "85"

-- Reducir el tiempo de actualización
vim.opt.updatetime = 100

-- Añadir el directorio actual al path de búsqueda
vim.opt.path:append(vim.fn.getcwd() .. "/**")

-- Añadir etiquetas de archivos al sistema de tags
vim.opt.tags:append("~/.local/share/nvim/site/tags")
vim.opt.tags:append("tags")

-- Desactivar el modo compatible con vi
vim.opt.compatible = false

-- Configuración del tipo de archivo
vim.cmd("filetype on")
vim.cmd("filetype indent on")
vim.cmd("filetype plugin indent on")

-- Habilitar resaltado de sintaxis
vim.cmd("syntax enable")

-- Resaltar la línea actual con un color gris en terminales compatibles
vim.cmd("highlight CursorLine ctermbg=grey")

-- Deshabilitar teclas de dirección en modo normal
vim.api.nvim_set_keymap('n', '<Up>', '<nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '<nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '<nop>', { noremap = true, silent = true })

-- Abrir archivos en divisiones verticales y horizontales
vim.api.nvim_set_keymap('n', '<Leader>v', '<C-w>vgf', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>h', '<C-w>f', { noremap = true, silent = true })

-- Terminal emulation
vim.api.nvim_set_keymap('n', '<Leader>sh', ':terminal<CR>', { noremap = true, silent = true })

-- Set working directory
vim.api.nvim_set_keymap('n', '<Leader>.', ':lcd %:p:h<CR>', { noremap = true, silent = true })

-- Search and replace
vim.api.nvim_set_keymap('n', '<F3>', ':%s/<C-r><C-w>//gc<Left><Left><Left>', { noremap = true })

-- Mejor navegación con 'n' y 'N'
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

-- Acciones comunes
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>q!', ':q!<CR>', { noremap = true, silent = true })

-- Navegación entre ventanas
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true })

-- Navegación entre pestañas
vim.api.nvim_set_keymap('n', '<Tab>', 'gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', 'gT', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-t>', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>te', ':tabedit<cfile><CR>', { noremap = true, silent = true })

-- Limpiar coincidencias de búsqueda
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':nohlsearch<CR>', { noremap = true, silent = true })

-- Definir macros personalizadas
vim.api.nvim_set_keymap('n', 'mu', ':normal! ddkP<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'md', ':normal! ddp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'u1', ':normal! yypVr=<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'u2', ':normal! yyPVr=<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'u3', ':normal! yypVr=kPVr=<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>"', 'viw<esc>a"<esc>bi"<esc>lel', { noremap = true })

-- Navegación en buffers
vim.api.nvim_set_keymap('n', '<Leader>z', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>x', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>c', ':bd<CR>', { noremap = true })
vim.cmd('command! Bda execute ":%bd|e#"')
vim.api.nvim_set_keymap('n', '<Leader>ca', ':Bda<CR>', { noremap = true })

-- Matemáticas simples
vim.api.nvim_set_keymap('n', '\\|m', '0yt=A<C-r>=<C-r>"<CR>', { noremap = true })

-- ===================
-- Insert Mode Mapping
-- ===================

-- Centrar cursor cuando se presiona ESC
vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>zz', { noremap = true })

-- Poner la palabra actual en mayúsculas
vim.api.nvim_set_keymap('i', '<C-u>', '<esc>viwUi', { noremap = true })

-- Moverse con hjkl en modo insert
vim.api.nvim_set_keymap('i', '<A-k>', '<C-o>k', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<C-o>j', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-l>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-h>', '<Left>', { noremap = true })

-- Mapas adicionales para modo insert
vim.api.nvim_set_keymap('i', '<A-a>', '<esc>a', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-o>', '<esc>o', { noremap = true })

vim.api.nvim_set_keymap('i', 'II', '<Esc>I', { noremap = true })
vim.api.nvim_set_keymap('i', 'AA', '<Esc>A', { noremap = true })
vim.api.nvim_set_keymap('i', 'OO', '<Esc>O', { noremap = true })

-- Deshabilitar teclas de dirección en modo insert
vim.api.nvim_set_keymap('i', '<Up>', '<nop>', { noremap = true })
vim.api.nvim_set_keymap('i', '<Down>', '<nop>', { noremap = true })

-- Mapeo para omnifunc
vim.api.nvim_set_keymap('i', '<C-Space>', '<C-x><C-o>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-@>', '<C-Space>', { noremap = true })

-- ==================
-- Visual Mode Mapping
-- ==================

-- Mantener selección visual tras moverla con '>' o '<'
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- Mover selección visual
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- ====================
-- Command Mode Mapping
-- ====================
vim.api.nvim_set_keymap('c', '<C-p>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-n>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-f>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-b>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-d>', '<Del>', { noremap = true })
vim.api.nvim_set_keymap('c', '<A-l>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('c', '<A-h>', '<Left>', { noremap = true })

