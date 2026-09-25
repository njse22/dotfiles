return {
	-- Snippets
	{
		"honza/vim-snippets",
		config = function()
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
		event = { "BufReadPre", "BufNewFile" },
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
				signcolumn                   = false, -- Muestra la columna de signos (la barra lateral)
				numhl                        = false, -- Cambiar a true si quieres que el NÚMERO de línea cambie de color
				linehl                       = false, -- Cambiar a true si quieres que TODA la línea de fondo cambie de color
				word_diff                    = false, -- Cambiar a true para ver cambios dentro de la misma línea (muy útil)

				-- Configuración del "Blame" (Texto fantasma)
				current_line_blame           = true, -- Muestra quién modificó la línea donde está el cursor
				current_line_blame_opts      = {
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

	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {
				embed_image_as_base64 = false,
				prompt_for_file_name = false,
				drag_and_drop = {
					insert_mode = true,
				},
			},
			filetypes = {
				markdown = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					dir_path = "assets/img",
					extension = "png",
					relative_to_current_file = true,
				},
			},
		},
		keys = {
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste from clipboard" },
		},
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
		opts = {}
	},

	{
		'blackhat-7/vellum.nvim',
		ft = 'markdown',
		keys = { { '<leader>mp', '<cmd>Vellum<cr>', desc = 'Markdown preview' } },
		opts = {},
	},

	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		-- keys = {
		-- 	{ "<leader>i", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "AI Inline Completion" },
		-- 	{ "<leader>ch", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "AI Chat" },
		-- 	{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
		-- },
		config = function()
			local default_model = "codegemma:7b"
			local available_models = {
				"codegemma:7b",
			}
			local current_model = default_model

			local function select_model()
				vim.ui.select(available_models, {
					prompt = "Select  Model:",
				}, function(choice)
					if choice then
						current_model = choice
						vim.notify("Selected model: " .. current_model)
					end
				end)
			end

			vim.keymap.set("n", "<leader>cs", select_model, { desc = "Select Model" })

			require("codecompanion").setup({
				strategies = {
					chat = { adapter = "ollama" },
					inline = { adapter = "ollama" },
					agent = {
						adapter = "ollama",
						tools = {
							"cmd_runner",
							"editor",
						}
					},
				},
				interactions = {
					chat = {
						opts = {
							completion_provider = "coc", -- blink|cmp|coc|default
						}
					}
				},
				display = {
					chat = {
						window = {
							layout = "vertical",
							position = "right",
							width = 0.4,
						},
						icons = {
							buffer_sync_all = "󰪴 ",
							buffer_sync_diff = " ",
							chat_context = " ",
							chat_fold = " ",
							tool_pending = "  ",
							tool_in_progress = "  ",
							tool_failure = "  ",
							tool_success = "  ",
						},
					}
				},
				adapters = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							schema = {
								model = {
									default = default_model,
								},
							},
							parameters = {
								temperature = 0.1,
							},
						})
					end,
				},
			})
		end,
	},

	--{
	--	"olimorris/codecompanion.nvim",
	--	dependencies = {
	--		"nvim-lua/plenary.nvim",
	--		"nvim-treesitter/nvim-treesitter",
	--	},
	--	config = function()
	--		require("codecompanion").setup({
	--			strategies = {
	--				chat = {
	--					adapter = "gemini",
	--				},
	--				inline = {
	--					adapter = "gemini",
	--				},
	--				agent = {
	--					adapter = "gemini",
	--				},
	--			},
	--			adapters = {
	--			    http = {
	--				gemini = function()
	--					return require("codecompanion.adapters").extend("gemini", {
	--						schema = {
	--							model = {
	--								default = "gemma-3-27b-it"-- "gemini-2.5-flash-lite",
	--							},
	--						},
	--						env = {
	--							api_key = os.getenv("GEMINI_API_KEY"),
	--						},
	--					})
	--				end,
	--			    }
	--			}
	--			--adapters = {
	--			--  gemini = function()
	--			--    return require("codecompanion.adapters").extend("gemini", {
	--			--      env = {
	--			--        api_key = os.getenv("GEMINI_API_KEY"), -- Lee tu variable de entorno
	--			--      },
	--			--      schema = {
	--			--        model = {
	--			--          default = "gemini-1.5-flash", -- O "gemini-1.5-pro"
	--			--        },
	--			--      },
	--			--    })
	--			--  end,
	--			--},
	--		})
	--	end,
	--},
}
