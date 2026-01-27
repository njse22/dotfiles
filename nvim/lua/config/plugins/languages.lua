return {
	-- ------------------------------
	-- LaTeX
	-- ------------------------------
	{
		"lervag/vimtex",
		ft = { "tex", "bib" },
		init = function()
			vim.g.vimtex_compiler_method = "latexmk"

			-- Ref: https://github.com/lervag/vimtex/issues/3043
			vim.g.vimtex_view_method = "zathura_simple"
			vim.g.vimtex_quickfix_mode = 0
		end,
	},

	{
		"artisticat1/obsidian-latex-suite",
		ft = "tex",
	},

	-- ------------------------------
	-- Markdown
	-- ------------------------------
	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			file_types = { "markdown", "codecompanion" },
			code = { sign = false, width = "block", right_pad = 1 },
			heading = { sign = false, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
		},
		ft = { "markdown", "codecompanion" },
	},
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
	},

	{
		"yousefhadder/markdown-plus.nvim",
		ft = "markdown",
		opts = {},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "work",
					path = "~/Documents/vaults/work",
				},
			},
			picker = {
				name = "fzf-lua",
			},
			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
			},
			ui = { enable = false },
		},
	},

	-- ------------------------------
	-- Treesitter
	-- ------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- ------------------------------
	-- Java / Springboot / Gradle
	-- ------------------------------
	{
		'javiorfo/nvim-springtime',
		lazy = true,
		cmd = { "Springtime", "SpringtimeUpdate" },
		dependencies = {
			"javiorfo/nvim-popcorn",
			"javiorfo/nvim-spinetta",
		},
		build = function()
			require 'springtime.core'.update()
		end,
		opts = {
			-- This section is optional
			-- If you want to change default configurations
			-- In packer.nvim use require'springtime'.setup { ... }

			-- Springtime popup section
			spring = {
				-- Project: Gradle, Gradle Kotlin and Maven (Gradle default)
				project = {
					selected = 1
				},
				-- Language: Java, Kotlin and Groovy (Java default)
				language = {
					selected = 1
				},
				-- Packaging: Jar and War (Jar default)
				packaging = {
					selected = 1
				},
				-- Project Metadata defaults:
				-- Change the default values as you like
				-- This can also be edited in the popup
				project_metadata = {
					group = "com.example",
					artifact = "demo",
					name = "demo",
					package_name = "com.example.demo",
					version = "0.0.1-SNAPSHOT"
				}
			},

			-- Some popup options
			dialog = {
				-- The keymap used to select radio buttons (normal mode)
				selection_keymap = "<C-Space>",

				-- The keymap used to generate the Spring project (normal mode)
				generate_keymap = "<C-CR>",

				-- If you want confirmation before generate the Spring project
				confirmation = true,

				-- Highlight links to Title and sections for changing colors
				style = {
					title_link = "Boolean",
					section_link = "Type"
				}
			},

			-- Workspace is where the generated Spring project will be saved
			workspace = {
				-- Default where Neovim is open
				path = vim.fn.expand("%:p:h"),

				-- Spring Initializr generates a zip file
				-- Decompress the file by default
				decompress = true,

				-- If after generation you want to open the folder
				-- Opens the generated project in Neovim by default
				open_auto = true
			},

			-- This could be enabled for debugging purposes
			-- Generates a springtime.log with debug and errors.
			internal = {
				log_debug = false
			}
		}
	},
	{

		"oclay1st/gradle.nvim",
		lazy = true,
		cmd = { "Gradle", "GradleExec", "GradleInit", "GradleFavorites" },
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" }
	},

	-- RouterOS Syntax
	{
		"krcs/vim-routeros-syntax",
		lazy = true,
		ft = "rsc",

	}
}
