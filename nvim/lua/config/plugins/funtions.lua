-- Table of Content with FZF
vim.keymap.set("n", "<localleader>lt", function()
	return require("vimtex.fzf-lua").run()
end)

------------------------------------------------------------------------
--                      Integration COC and FZF                       --
------------------------------------------------------------------------
local function coc_commands_fzf()
	local fzf = require("fzf-lua")
	local commands = vim.fn.CocAction('commands')

	if not commands or type(commands) ~= "table" or #commands == 0 then
		vim.notify("No se encontraron referencias (Coc)", vim.log.levels.WARN)
		return
	end

	local items = {}
	for _, command in ipairs(commands) do
		local id = command.id
		local title = command.title
		local entry = string.format("%s : [ %s ]" , id, title)
		table.insert(items, entry)
	end

	fzf.fzf_exec(items, {
	    prompt = 'CocCommands> ',
	    actions = {
		["default"] = function (selected)
		    local sel = selected[1]
		    local id , title = sel:match("^(.-)%s*:%s*(.*)$")
		    vim.cmd("CocCommand "..id)
		    vim.notify(title, vim.log.INFO)
		end
	    }
	})
end

local function coc_references_fzf()
	local fzf = require("fzf-lua")
	local actions = require('fzf-lua.actions')
	local references = vim.fn.CocAction('references')

	if not references or type(references) ~= "table" or #references == 0 then
		vim.notify("No references available", vim.log.levels.WARN)
		return
	end

	local items = {}
	for _, ref in ipairs(references) do
		local filepath = vim.uri_to_fname(ref.uri)
		local relative_path = vim.fn.fnamemodify(filepath, ":.")
		local lnum = ref.range.start.line + 1
		local col = ref.range.start.character + 1
		local entry = string.format("%s:%d:%d", relative_path, lnum, col)
		table.insert(items, entry)
	end

	fzf.fzf_exec(items, {
		prompt = 'CocReferences> ',
		previewer = "builtin",
		actions = {
		  ["default"] = actions.file_edit,
		  ["ctrl-s"]  = actions.file_split,
		  ["ctrl-v"]  = actions.file_vsplit,
		  ["ctrl-t"]  = actions.file_tabedit,
		}
	})
end

local function coc_diagnostics_fzf()
	local fzf = require('fzf-lua')
	local diagnostics = vim.fn.CocAction('diagnosticList')

	if vim.tbl_isempty(diagnostics) then
		vim.notify("FzfCocDiagnostics: No diagnostics in current buffer", vim.log.levels.WARN)
		return
	end

	local items = {}
	for _, d in ipairs(diagnostics) do
		local severity_icon = d.severity == 'Error' and "E" or (d.severity == 'Warning' and "W" or "I")
		local entry = string.format("%s:%d:%d: [%s] %s",
			d.file,
			d.lnum,
			d.col,
			severity_icon,
			d.message
		)
		table.insert(items, entry)
	end

	fzf.fzf_exec(items, {
		prompt = 'CocDiagnostics> ',
		previewer = "builtin",

		actions = {
			['default'] = function(selected)
				local sel = selected[1]
				local file, line, col = sel:match("^(.-):(%d+):(%d+):")
				if file then
					vim.cmd("edit " .. file)
					vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 })
					vim.cmd("normal! zz")
				end
			end
		}
	})
end

-- =============================================================================
-- 1. LÓGICA DE PROCESAMIENTO (Calcula anchos y extrae keys)
-- =============================================================================
local function parse_columns(columns_data)
	local rendered_cols = {}
	local keymaps = {}
	local max_height = 0

	for _, col_data in ipairs(columns_data) do
		local lines = {}
		local max_width = 0

		-- CASO A: Columna de Menú (tiene items con keys)
		if col_data[1] and col_data[1].key then
			for _, item in ipairs(col_data) do
				-- Formato " key: Label"
				local str = string.format("%3s: %s", item.key, item.label)
				table.insert(lines, str)

				-- Calcular ancho visual (para caracteres unicode)
				local w = vim.fn.strdisplaywidth(str)
				if w > max_width then max_width = w end

				-- Guardar la acción del keymap
				if item.cmd then
					keymaps[item.key] = function(win)
						win:close()
						if type(item.cmd) == "function" then
							item.cmd()
						elseif type(item.cmd) == "string" then
							vim.cmd(item.cmd)
						end
					end
				end
			end

			-- CASO B: Columna de Texto Plano (ej. Logo)
		elseif col_data.text_lines then
			lines = col_data.text_lines
			for _, line in ipairs(lines) do
				local w = vim.fn.strdisplaywidth(line)
				if w > max_width then max_width = w end
			end
		end

		if #lines > max_height then max_height = #lines end
		table.insert(rendered_cols, { lines = lines, width = max_width })
	end

	return rendered_cols, keymaps, max_height
end

-- =============================================================================
-- 2. LÓGICA DE RENDERIZADO (Une las columnas en un solo string)
-- =============================================================================
local function render_layout(rendered_cols, height, gap_size)
	local final_lines = {}
	local gap = string.rep(" ", gap_size or 3)

	for i = 1, height do
		local row_segments = {}

		for _, col in ipairs(rendered_cols) do
			local text = col.lines[i] or ""
			-- Rellenar con espacios hasta alcanzar el ancho de la columna
			local padding = string.rep(" ", col.width - vim.fn.strdisplaywidth(text))
			table.insert(row_segments, text .. padding)
		end

		-- Unir los segmentos de la fila con el separador (gap)
		table.insert(final_lines, table.concat(row_segments, gap))
	end

	return table.concat(final_lines, "\n")
end

-- =============================================================================
-- 3. FUNCIÓN PRINCIPAL (Define datos y crea la ventana)
-- =============================================================================
function _G.open_dashboard_win()
	local fzf = require('fzf-lua')

	-- --- DATOS ---
	local logo = {
		"  🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼   ",
		" 🭉🭁🭠🭘    🭣🭕🭌🬾  ",
		" 🭅█ ▁     █🭐  ",
		" ██🬿      🭊██  ",
		"🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀 ",
		"🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙 "
	}

	local columns_data = {
		-- Col 3: Logo
		{ text_lines = logo },
		-- Col 1: Archivos
		{
			{ key = "ff", label = "Files",     cmd = fzf.files },
			{ key = "fo", label = "Old Files", cmd = fzf.oldfiles },
			{ key = "fg", label = "Live Grep", cmd = fzf.live_grep },
			{ key = "fb", label = "Buffers",   cmd = fzf.buffers },
			{ key = "fk", label = "Key Maps",  cmd = fzf.keymaps },
			{ key = "fh", label = "Manpages",  cmd = fzf.manpages },
		},
		-- Col 2: Git/Search
		{
			{ key = "ga", label = "Git Blame",   cmd = fzf.git_blame },
			{ key = "gs", label = "Git Status",  cmd = fzf.git_status },
			{ key = "gc", label = "Git Commits", cmd = fzf.git_commits },
			{ key = "ld", label = "Diagnostics", cmd = function() coc_diagnostics_fzf() end },
			{ key = ":",  label = "Cmd History", cmd = Snacks.picker.command_history },
			{ key = "/",  label = "Search Hist", cmd = Snacks.picker.search_history },
		},
	}

	-- --- ORQUESTACIÓN ---

	-- Process columns
	local rendered_cols, keys, height = parse_columns(columns_data)

	-- Render text
	local final_text = render_layout(rendered_cols, height, 4)

	final_text = final_text .. "\n\n  <Esc>: Close"
	keys["<Esc>"] = "close"
	keys["q"] = "close"
	keys["<CR>"] = function(win)
		win:close(); Snacks.picker.smart()
	end

	-- 4. Crear Ventana
	Snacks.win({
		width = 60,
		height = 8,
		title = " Helper Menu ",
		border = "rounded",
		text = final_text,
		keys = keys,
		bo = { filetype = "markdown", buftype = "nofile" },
		wo = { winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder", cursorline = false },
	}):show()
end

------------------------------------------------------------------------
--                              keymaps                               --
------------------------------------------------------------------------
vim.keymap.set("n", "<leader>wm", _G.open_dashboard_win, { desc = "Helper Menu" })

vim.api.nvim_create_user_command('FzfCocDiagnostics', coc_diagnostics_fzf, {})
vim.keymap.set("n", "<leader>fd", coc_diagnostics_fzf,
	{ desc = "coc diagnostics with fzf" })

vim.api.nvim_create_user_command('FzfCocReferences', coc_references_fzf, {})
vim.keymap.set("n", "<leader>fr", coc_references_fzf,
	{ desc = "coc diagnostics with fzf" })

vim.api.nvim_create_user_command('FzfCocCommands', coc_commands_fzf , {})

-- Snacks.toggle.zen():map("<leader>sz")
-- Snacks.toggle.dim():map("<leader>sd")

-- Keymap for testing
-- vim.keymap.set("n", "<leader>mm", coc_references_fzf, { desc = " ", silent = true })
