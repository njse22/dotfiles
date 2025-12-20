return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp", -- Necesario para orden de carga
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls", "pyright", "ansiblels", "yamlls",
          "dockerls", "clangd", "jdtls", "jsonls", "bashls",
          "marksman", "texlab",
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            local opts = { capabilities = capabilities }
            if server_name == "yamlls" then
              opts.settings = { yaml = { schemas = { kubernetes = "*.yaml" } } }
            end
            require("lspconfig")[server_name].setup(opts)
          end,
        }
      })

      -- Keymaps LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end,
      })

      vim.diagnostic.config({ float = { border = "rounded" } })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    end,
  },
}