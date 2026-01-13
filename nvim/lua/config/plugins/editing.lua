return {
    -- Snippets
    {
	"honza/vim-snippets",
	config = function ()
	    vim.g.snips_author = "Nicolas J. Salazar E. (njse22)"
	end
    },

    -- Git
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
        ft = { "fugitive" },
        config = function()
            vim.api.nvim_set_keymap('n', '<Leader>ga', ':Gwrite<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>gc', ':Gcommit<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>gsh', ':Gpush<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>gll', ':Gpull<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>gs', ':Gstatus<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>gb', ':Gblame<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>gd', ':Gvdiff<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>gr', ':Gremove<CR>', { noremap = true, silent = true })
        end
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {
            --signs = {
            --    -- Usamos barras verticales y caracteres más estéticos
            --    add          = { text = '┃' },
            --    change       = { text = '┃' },
            --    delete       = { text = '_' },
            --    topdelete    = { text = '‾' },
            --    changedelete = { text = '~' },
            --    untracked    = { text = '┆' },
            --},
            signcolumn = false,  -- Muestra la columna de signos (la barra lateral)
            numhl      = false, -- Cambiar a true si quieres que el NÚMERO de línea cambie de color
            linehl     = false, -- Cambiar a true si quieres que TODA la línea de fondo cambie de color
            word_diff  = false, -- Cambiar a true para ver cambios dentro de la misma línea (muy útil)

            -- Configuración del "Blame" (Texto fantasma)
            current_line_blame = true, -- Muestra quién modificó la línea donde está el cursor
            current_line_blame_opts = {
        	virt_text = true,
        	virt_text_pos = 'eol', -- 'eol' = end of line (al final de la línea)
        	delay = 300,
        	ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
            }
        end
    },

    -- Alignment
    {
        "junegunn/vim-easy-align",
        cmd = "EasyAlign",
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    bash = { "shfmt" },
                    zsh = { "shfmt" },
                    sh = { "shfmt" },
                    tex = { "latexindent" },
                },

                formatters = {
                    shfmt = {
                    prepend_args = { "-i", "2" },
                    },
                },

                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ bufnr = args.buf })
                end,
            })
        end,
    },

    {
    "folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	opts = { }
    }

}
