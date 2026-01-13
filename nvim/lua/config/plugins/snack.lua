-- TODO:  <28-12-25, Nicolas J. Salazar E. (njse22)> Validate how to use with new plugin --
local headers = require "headers.headers"
local utils = require('utils.utils')

return {
    {
	"folke/snacks.nvim",

	priority = 1000,
	lazy = false,
	opts = {
	    bigfile = { enabled = false },
	    indent = {
		enabled = true,
		scope = {
		    enabled = true,
		    char = "│",
		},
	    },

	dashboard = {
	    width = 60,
	    pane_gap = 4,
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
				    key = "vc",
				    desc = "Config File",
				    action = ":e ~/.config/nvim/init.lua"
			    },
			    -- TODO:  <28-12-25, Nicolas J. Salazar E. (njse22)> -- Define function or plugin to manage sessions
			    -- {
			    --     icon = " ",
			    --     key = "s",
			    --     desc = "Restore Session",
			    --     section = "session"
			    -- },
			    {
				    icon = "󰒲 ",
				    key = "L",
				    desc = "Lazy",
				    action = ":Lazy",
				    enabled = package.loaded.lazy ~= nil
			    },
			    {
				    icon = " ",
				    key = "q",
				    desc = "Quit",
				    action = ":qa"
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
]],
	    },
	    sections = {
		    { section = "header" },
		    { section = "keys",   gap = 1, padding = 1 },
		    { section = "startup" },
	    },
	},
	    dim          = { enabled = true },
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
	    gitbrowse    = { enabled = true },
	    rename       = { enabled = true },
	    profiler     = { enabled = false },
	    git          = { enabled = false }, -- FzfLua git_blame is better for me
	    explorer     = { enabled = false }, -- I don't liked
	    lazygit      = { enabled = false }, -- Not installed
	    picker       = { enabled = false }, -- Remplaced with FzfLua
	    lazy         = { enabled = false }, -- TODO:  <28-12-25, Nicolas J. Salazar E. (njse22)> -- what is this ?
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
	    styles       = {
		    notification = {
			    wo = { wrap = true }
		    }
	    }
    },
    keys = {
	    {
		    "<leader>:",
		    function()
			    Snacks.picker.command_history()
		    end,
		    desc = "Command History"
	    },

	    {
		    "<leader>gB",
		    function()
			    Snacks.gitbrowse()
		    end,
		    desc = "Open in browser"
	    },
	    {
		    "<leader>bd",
		    function()
			    Snacks.bufdelete()
		    end,
		    desc = "Delete Buffer"
	    },

	    {
		    "<leader>cR",
		    function()
			    Snacks.rename.
				    rename_file()
		    end,
		    desc = "Rename File"
	    },

	    {
		    "<leader>un",
		    function()
			    Snacks.notifier.hide()
		    end,
		    desc = "Dismiss All Notifications"
	    },

	    {
		    "<leader>sh",
		    function()
			    Snacks.terminal()
		    end,
		    desc = "Toggle Terminal"
	    },
	    {
		    "<leader>sz",
		    function()
			    Snacks.toggle.zen():toggle()
		    end,
		    desc = "Toggle Zen Mode"
	    },
	    {
		    "<leader>sd",
		    function()
			    Snacks.toggle.dim():toggle()
		    end,
		    desc = "Toggle Dim"
	    },
	    -- TODO:  <28-12-25, Nicolas J. Salazar E. (njse22)> -- Evaluate if this is good for notes taking
	    -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Pad" },
	    -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Pad" },
	}
    }
}
