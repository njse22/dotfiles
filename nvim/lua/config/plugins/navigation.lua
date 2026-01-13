return {
    -- NERDTree
    {
        "preservim/nerdtree",
        cmd = "NERDTreeToggle",
        keys = {
            { "<leader>n", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
        },
        config = function()
            vim.g.nerdtree_tabs_autoclose = 0
            vim.g.NERDSpaceDelims = 1
            vim.g.NERDDefaultAlign = 'left'
            vim.g.NERDTreeDirArrowExpandable = '▸'
            vim.g.NERDTreeDirArrowCollapsible = '▾'
            vim.g.NERDTreeChDirMode = 2
            vim.g.NERDTreeIgnore =
	    { '\\.rbc$', '\\~$', '\\.pyc$', '\\.db$', '\\.sqlite$', '__pycache__' }
            vim.g.NERDTreeSortOrder =
	    { '^__\\.py$', '\\/$', '*', '\\.swp$', '\\.bak$', '\\~$' }
            vim.g.nerdtree_tabs_focus_on_files = 1
            vim.g.NERDTreeWinSize = 25
        end,
    },

    -- Fzf-lua
    {

        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "FzfLua",
        keys = {
            { "<C-p>",
		function()
		    require("fzf-lua").files()
		end, desc = "Find Files" },
            { "<leader>fg",
		function()
		    require("fzf-lua").live_grep()
		end, desc = "Search" },
            { "<leader>fb",
		function()
		    require("fzf-lua").buffers()
		end, desc = "Buffers" },
            { "<leader>fk",
		function()
		    require("fzf-lua").keymaps()
		end, desc = "Keymaps" },
            { "<leader>gs",
		function()
		    require("fzf-lua").git_status()
		end, desc = "Git Commits" },
            { "<leader>ga",
		function()
		    require("fzf-lua").git_blame()
		end, desc = "Git Blame" },
            { "<leader>gb",
		function()
		    require("fzf-lua").git_branches()
		end, desc = "Git Branches" },
            { "<leader>gc",
		function()
		    require("fzf-lua").git_commits()
		end, desc = "Git Commits" },
            { "<leader>ñ",
		function()
		    require("fzf-lua").spell_suggest()
		end, desc = "Spell Suggest" },
            { "<C-x><C-f>",
		function()
		    require("fzf-lua").complete_path()
		end, mode = { "n", "v", "i" }, desc = "Fuzzy complete path" },
        },
        config = function()
            local fzf = require('fzf-lua')

            fzf.setup{
		-- "border-fused",
		-- "borderless-full",
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

}
