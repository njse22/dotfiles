local headers = require "headers.headers"
local utils = require('utils.utils')

return {
    {
        "folke/snacks.nvim",

        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            indent = {
                enabled = true,
                scope = {
                    enabled = true,
                    char = "│",
                },
            },
            dashboard = {
		enabled = true,
		preset = {
		    keys = {
			{
			    icon = " ",
			    key = "e",
			    desc = "New File",
			    action = ":ene | startinsert"
			},
			{
			    icon = "󰉋 ",
			    key = "mk",
			    desc = "New Directory",
			    action = utils.create_new_dir
			},
			{
			    icon = " ",
			    key = "fp",
			    desc = "Find File",
			    action = function() require("fzf-lua").files() end,
			},
			{
			    icon = " ",
			    key = "fg",
			    desc = "Find Text",
			    action = function() require("fzf-lua").live_grep() end,
			},
			{
			    icon = " ",
			    key = "fr",
			    desc = "Recent Files",
			    action = function() require("fzf-lua").oldfiles() end
			},
			{
			    icon = " ",
			    key = "c",
			    desc = "Config File",
			    action = "e ~/.config/nvim/init.lua"
			},
			-- {
			--     icon = " ",
			--     key = "s",
			--     desc = "Restore Session",
			--     section = "session"
			-- },
			{
			    icon = "󰒲 ",
			    key = "L",
			    desc = "Lazy on",
			    action = ":Lazy", enabled = package.loaded.lazy ~= nil
			},
			{
			    icon = " ",
			    key = "q",
			    desc = "Quit", action = ":qa"
			},
		    },

		    header = [[
		         ⠀⠀⢀⡤⢤⢄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		        ⠀⠀⠀⣼⡅⠠⢀⡈⢀⣙⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠤⠤⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		        ⠀⠀⠀⢸⠀⠀⠀⠈⠙⠿⣝⢇⠀⠀⣀⣠⠤⠤⠤⠤⣤⡤⠚⠁⠀⠀⠀⠀⠀⠉⠢⡀⠀⠀⠀⠀⠀⠀
		        ⠀⠀⠀⠀⢧⡀⠀⠀⠠⣄⠈⢺⣺⡍⠀⠀⠀⠀⣠⠖⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀
		        ⠀⠀⠀⠀⠸⡆⢀⠘⣔⠄⠑⠂⠈⠀⡔⠤⠴⠚⡁⠀⠀⢀⠀⠀⠀⣠⠔⢶⡢⡀⠀⠠⡇⠀⠀⠀⠀⠀
		        ⠀⠀⠀⠀⢠⣇⠀⢃⡀⠁⠀⠀⠀⡸⠃⢀⡴⠊⢀⠀⠀⠈⢂⡤⠚⠁⠀⠀⠙⢿⠀⠉⡇⠀⠀⠀⠀⠀
		        ⠀⠀⠀⣠⠾⣹⢤⢼⡆⠀⠀⠀⠀⠀⠀⠈⢀⠞⠁⠀⢠⣴⠏⠀⠀⠀⠀⠀⠀⠸⡇⠀⢇⠀⠀⠀⠀⠀
		        ⠀⠀⣾⢡⣤⡈⠣⡀⠙⠒⠀⠀⠀⠀⣀⠤⠤⣤⠤⣌⠁⢛⡄⠀⠀⠀⠀⠀⠠⡀⢇⠀⠘⣆⠀⢀⡴⡆
		        ⠀⠀⣿⢻⣿⣿⣄⡸⠀⡆⠀⠒⣈⣩⣉⣉⡈⠉⠉⠢⣉⠉⠀⠀⠀⠀⠀⠀⠀⢣⠈⠢⣀⠈⠉⢁⡴⠃
		        ⠀⢀⢿⣿⣿⡿⠛⠁⠀⢻⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⣸⢿⠀⠀⠀⠀⠀⠀⠀⠸⡄⠀⡇⠉⠉⠁⠀⠀
		        ⣠⣞⠘⢛⡛⢻⣷⣤⡀⠈⡎⣿⣿⣿⣿⣿⣿⣿⣿⣿⠹⠏⠀⠀⠀⠀⠀⠀⠀⠀⠇⢰⡇⠀⠀⠀⠀⠀
		        ⠻⣌⠯⡁⢠⣸⣿⣿⣷⡄⠁⠈⢻⢿⣿⣿⣿⣿⠿⠋⠃⠰⣀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠇⠀⠀⠀⠀⠀
		        ⠀⠀⠉⢻⠨⠟⠹⢿⣿⢣⠀⠀⢨⡧⣌⠉⠁⣀⠴⠊⠑⠀⡸⠛⠀⠀⠀⠀⠀⣸⢲⡟⠀⠀⠀⠀⠀⠀
		        ⠀⠀⣠⠏⠀⠀⠀⠉⠉⠁⠀⠐⠁⠀⠀⢉⣉⠁⠀⠀⢀⠔⢷⣄⠀⠀⠀⠀⢠⣻⡞⠀⠀⠀⠀⠀⠀⠀
		        ⠀⢠⠟⡦⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⢾⠉⠀⣹⣦⠤⣿⣿⡟⠁⠀⠀⠀⢀⣶⠟⠀⠀⠀⠀⠀⠀⠀⠀
		        ⠀⠈⠙⣦⣁⡎⢈⠏⢱⠚⢲⠔⢲⠲⡖⠖⣦⣿⡟⠀⣿⡿⠁⣠⢔⡤⠷⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
		        ⠀⠀⢿⣟⠿⡿⠿⠶⢾⠶⠾⠶⠾⠞⢻⠋⠏⣸⠁⠀⡽⠓⠚⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		        ⠀⠀⢸⡏⠳⠷⠴⠣⠜⠢⠜⠓⠛⠊⠀⢀⡴⠣⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		        ⠀⠀⣏⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⠁⢀⣀⣀⠴⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		        ⠀⠀⠘⢦⡀⠀⠀⠀⠀⠀⠀⢀⣀⠴⠖⠒⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		        ⠀⠀⠀⠀⠉⠑⠒⠒⠐⠒⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
		    ]]
		}
	    },
            input        = { enabled = true },
            quickfile    = { enabled = true },
            scope        = { enabled = true },
            scroll       = { enabled = true },
            statuscolumn = { enabled = true },
            words        = { enabled = true },
            zen          = { enabled = true },
            terminal     = { enabled = true },
            toggle       = { enabled = true },
            debug        = { enabled = true },
            dim          = { enabled = true },
            gitbrowse    = { enabled = true },
            rename       = { enabled = true },
            profiler     = { enabled = false },
            git          = { enabled = false }, -- FzfLua git_blame is better for me
            explorer     = { enabled = false }, -- I don't liked
            lazygit      = { enabled = false },
            lazy         = { enabled = false },
            picker       = { enabled = false }, -- Remplaced with FzfLua
            notifier     = {
                enabled = true,
                timeout = 3000
            },
            scratch      = {
                enabled = true,
                ft = "markdown",
                filekey = {
                    cwd = true,
                },
                win = {
                    style = "scratch",
                },
                actions = {
                    delete = true,
                }
            },
            styles = {
                notification = {
                    wo = { wrap = true }
                }
            }
        },
        keys = {
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Open in browser" },
            -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Pad" },
            -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Pad" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<leader>sh", function() Snacks.terminal() end, desc = "Toggle Terminal" },
        }
    }
}
