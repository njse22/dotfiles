local M = {}

function M.create_new_dir()
  vim.ui.input({ prompt = "Nombre del directorio: " }, function(input)
    if input then
      vim.cmd("!mkdir -p " .. input)
      vim.notify("Directorio creado: " .. input, vim.log.levels.INFO)
    end
  end)
end

return M
