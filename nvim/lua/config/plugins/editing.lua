return {
    -- Snippets
    { "honza/vim-snippets" },

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

    -- Alignment
    { "junegunn/vim-easy-align" },

    -- Formatting
    {
        "stevearc/conform.nvim",
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
    }
}
