-- Activa el corrector ortográfico
vim.opt_local.spell = true
-- Define los idiomas: Español e Inglés
vim.opt_local.spelllang = { 'en_us', 'es' }

-- Atajos rápidos para corrección:
-- [s  -> Ir al siguiente error
-- z=  -> Ver sugerencias de corrección
-- zg  -> Añadir palabra al diccionario

-- 3. Atajos útiles
-- <leader>lc -> Limpiar archivos auxiliares generados
-- <leader>ll -> Compilar (Toggle on/off)
-- <leader>lv -> Ver PDF (forward search)
