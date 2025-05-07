-- Configuración básica de mason.nvim
require("mason").setup()

-- Configuración de mason-lspconfig.nvim
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",         -- Lua (opcional, pero útil si trabajas con Lua)
        "texlab",         -- LaTeX
        "pyright",        -- Python
        "ansiblels",      -- Ansible
        "clangd",         -- C/C++
--        "solargraph",     -- Ruby
    },
    automatic_installation = true,  -- Instala automáticamente los LSP que faltan
})


-- Configuración de los servidores LSP
-- local lspconfig = require('lspconfig')
-- 
-- -- Configuración para LaTeX (texlab)
-- lspconfig.texlab.setup({
--     settings = {
--         texlab = {
--             build = {
--                 args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
--                 onSave = true,
--             },
--             forwardSearch = {
--                 executable = "zathura",
--                 args = { "--synctex-forward", "%l:1:%f", "%p" },
--             },
--         },
--     },
-- })

-- Función para configurar los LSP
local on_attach = function(client, bufnr)
  -- Aquí puedes agregar mapeos de teclas específicos para LSP
local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Configuración para LaTeX
-- lspconfig.texlab.setup{
--   on_attach = on_attach,
-- }
-- 
-- -- Configuración para Python
-- lspconfig.pyright.setup{
--   on_attach = on_attach,
-- }
-- 
-- -- Configuración para Ansible
-- lspconfig.ansiblels.setup{
--   on_attach = on_attach,
-- }
-- 
-- -- Configuración para C/C++
-- lspconfig.clangd.setup{
--   on_attach = on_attach,
-- }


-- Configuración de vimtex en Lua
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'

vim.g.vimtex_compiler_latexmk = {
    build_dir = 'build',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1',
        '-file-line-error',
    },
}

-- CMP 

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    })
})
