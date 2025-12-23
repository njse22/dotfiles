local M = {}

function M.create_new_dir()
  vim.ui.input({ prompt = "Nombre del directorio: " }, function(input)
    if input then
      vim.cmd("!mkdir -p " .. input)
      vim.notify("Directorio creado: " .. input, vim.log.levels.INFO)
    end
  end)
end

function M.query_ollama(prompt)
  local command = string.format(
    'curl -s http://i2thub.icesi.edu.co:11434/api/generate -d \'{"model": "deepseek-r1", "prompt": "%s"}\'',
    prompt
  )
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()

  -- Extraer la respuesta del JSON
  local response = ""
  for line in result:gmatch("[^\r\n]+") do
    local json = vim.json.decode(line)
    response = response .. json.response
  end

  -- Mostrar en un buffer
local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
  vim.api.nvim_command("vsplit | buffer " .. buf)
end

vim.keymap.set("n", "<leader>llm", function()
  vim.ui.input(
    { prompt = "Prompt para Ollama: " },
    function(input) 
      if input then
        M.query_ollama(input) 
      end
    end
  )
end, { desc = "Consultar a Ollama con prompt personalizado" })

return M
