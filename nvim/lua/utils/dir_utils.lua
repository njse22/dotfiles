local M = {}

function M.create_new_dir()
  vim.ui.input({ prompt = "Directory name: " }, function(input)
    if input then
      vim.cmd("!mkdir -p " .. input)
      vim.notify("Created: " .. input, vim.log.levels.INFO)
    end
  end)
end

return M
