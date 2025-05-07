" ======================
" DEFINE THEME FOR VIM
" ======================
if has('termguicolors')
    set termguicolors
endif

" ============
" FOREST-NIGHT
" ============
let g:forest_night_enable_italic          = 1
let g:forest_night_disable_italic_comment = 1
let g:forest_night_transparent_background = 0

" =========
" SPACEDUCK
" =========
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" ====
" CODE
" ====
let g:codedark_conservative = 1

" ========
" MATERIAL
" ========
let g:materail_array_colors = [
            \'default' ,
            \'palenight' ,
            \'ocean' ,
            \'lighter' ,
            \'darker' ,
            \'default-community' ,
            \'palenight-community' ,
            \'ocean-community' ,
            \'lighter-community' ,
            \'darker-community'
            \]
let g:material_terminal_italics = 1
let g:material_theme_style = g:materail_array_colors[1]

let g:colorsscheme_array = [
            \'forest-night',
            \'spaceduck',
            \'codedark',
            \'material',
            \'ayu',
            \'lighthaus'
            \]



let g:ayu_color_array = ["light", "migrate", "dark"]
let ayucolor =  g:ayu_color_array[2]

execute "colorscheme " . g:colorsscheme_array[4]
set background=dark

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
