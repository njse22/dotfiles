return {
    -- NERDTree
    {
        "preservim/nerdtree",
        cmd = "NERDTreeToggle",
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
        end,
    },

    -- Fzf-lua
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require('fzf-lua')

            fzf.setup{
                winopts = {
                height = 0.85,
                width = 0.85,
                border = "rounded",

                preview = {
                    default = 'bat',  -- Use bat for file previews
                    vertical = 'up:60%',  -- Preview window position
                    horizontal = 'right:60%',
                    layout = "flex",
                    border = "border-top",
                },
                },
                git = {
                file_icons = true,  -- Show Git icons for files
                },

                fzf_opts = {
                ['--layout'] = 'default',
                ['--print-query'] = "",
                },
                defaults = {
                prompt = "   ",
                cwd_prompt = false,
                },
            }

            vim.keymap.set('n',      '<C-p>', fzf.files,      {})
            vim.keymap.set('n', '<leader>fg', fzf.live_grep,  {})
            vim.keymap.set('n', '<leader>fb', fzf.buffers,    {})
            vim.keymap.set('n', '<leader>fk', fzf.keymaps,    {})
            vim.keymap.set('n', '<leader>gs', fzf.git_commit, {})
            vim.keymap.set('n', '<leader>gb', fzf.git_blame,  {})

            vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
            function() fzf.complete_path() end,
            { silent = true, desc = "Fuzzy complete path" })
        end
    },

    -- Tmux Navigator
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- RouterOS Syntax
    { "krcs/vim-routeros-syntax" }
}
