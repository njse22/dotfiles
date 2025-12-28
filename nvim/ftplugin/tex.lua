-- Activa el corrector ortográfico
vim.opt_local.spell = true
-- Define los idiomas: Español e Inglés
vim.opt_local.spelllang = { 'en_us', 'es' }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    -- 1. Define el ancho máximo (ej: 80 caracteres)
    vim.opt_local.textwidth = 80
    -- 2. Configura las opciones de formato
    -- 't': Auto-romper texto usando textwidth
    -- 'c': Auto-romper comentarios
    -- 'q': Permitir formatear con 'gq'
    vim.opt_local.formatoptions = "tcq"
  end,
})


-- Atajos rápidos para corrección:
-- gqip hard Wrapping
-- [s  -> Ir al siguiente error
-- z=  -> Ver sugerencias de corrección
-- zg  -> Añadir palabra al diccionario

-- 3. Atajos útiles
-- <leader>lc -> Limpiar archivos auxiliares generados
-- <leader>ll -> Compilar (Toggle on/off)
-- <leader>lv -> Ver PDF (forward search)
