" ============
" CALL PLUGINS
" ============

" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.local/share/nvim/site/plugged')

" Themes
Plug 'sainnhe/forest-night'
Plug 'tomasiser/vim-code-dark'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim'
Plug 'whatyouhide/vim-gotham'
Plug 'lifepillar/vim-solarized8' 

" IDE
Plug 'scrooloose/nerdtree'         " for navigate between files
Plug 'ryanoasis/vim-devicons'      " icons for NERDTREE
Plug 'Xuyuanp/nerdtree-git-plugin' " git status for NERDTree
Plug 'tpope/vim-fugitive'          " to use Git in vim
Plug 'tpope/vim-rhubarb'           " required by fugitive to :Gbrowse for open de file proyect in github
Plug 'vim-airline/vim-airline'     " graphical interface
Plug 'preservim/nerdcommenter'     " to make commentaries
Plug 'SirVer/ultisnips'            " to autocomplete code
Plug 'honza/vim-snippets'          " a set of snippets
Plug 'airblade/vim-gitgutter'      " a git extension
Plug 'Raimondi/delimitMate'        " autocompletion in insert mode
Plug 'dense-analysis/ale'          " SLP for multiples languages
Plug 'majutsushi/tagbar'           " a tool to navigate in code with tags
Plug 'xolox/vim-misc'              " this is nessesary for vim-session
Plug 'xolox/vim-session'           " this is for managemend sessions
Plug 'skywind3000/asyncrun.vim'    " for asyncronus terminal run
Plug 'tyru/open-browser.vim'       " for search in internet
Plug 'voldikss/vim-floaterm'       " pretty floting terminal for neovim
Plug 'junegunn/vim-easy-align'     " to aling code
Plug 'simnalamburt/vim-mundo'      " undo with esteroids
Plug 'Yggdroot/indentLine'
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
" Plug 'ervandew/supertab'
" Plug 'ycm-core/YouCompleteMe' , { 'do': './install.py --all' }
" Plug 'ycm-core/lsp-examples', {'do': './install.py --enable-ruby --enable-bash --enable-kotlin'}
Plug 'puremourning/vimspector', {'do': 
      \ 'python3 install_gadget.py --enable-vscode-cpptools --enable-python'}

" TODO: Stop make chnages here !! <26-01-21, Nicolas J. Salazar E.> "
Plug 'neoclide/coc.nvim', {'branch': 'release'}

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

" Python
" Plug 'davidhalter/jedi-vim'

" C++
" Plug 'vim-scripts/OmniCppComplete'
" Plug 'xavierd/clang_complete'
Plug 'vim-scripts/a.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'cdelledonne/vim-cmake'   " cmake

" HTML
Plug 'gko/vim-coloresque'
Plug 'mattn/emmet-vim'
" Plug 'hail2u/vim-css3-syntax'
Plug 'tpope/vim-haml'

" yaml
" Plug 'vim-scripts/yaml.vim'

" javascript
" Plug 'jelera/vim-javascript-syntax'
" Plug 'leafgarland/typescript-vim'
" Plug 'HerringtonDarkholme/yats.vim'

" java
Plug 'artur-shaik/vim-javacomplete2'
" Plug 'vim-scripts/javaRun'

" GNU Radio
Plug 'njse22/gr-vim'
" Plug 'mbr0wn/grproject.vim'

" ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring', {'tag': 'main'}

" LaTex
Plug 'lervag/vimtex'

call plug#end()

" =================================
" PLUGING MAPING AND CONFIGURATION
" =================================

" ==========
"  JEDI-VIM
" ==========
let g:jedi#popup_on_dot             = 0
let g:jedi#goto_assignments_command = "<Leader>ga"
let g:jedi#goto_definitions_command = "<Leader>gd"
let g:jedi#documentation_command    = "K"
let g:jedi#usages_command           = "<Leader>n"
let g:jedi#rename_command           = "<Leader>r"
let g:jedi#show_call_signatures     = "0"
let g:jedi#completions_command      = "<C-Space>"
let g:jedi#smart_auto_mappings      = 0

" path to directory where library can be found
let g:clang_library_path='/usr/lib/llvm-10/lib'

" =======
" OMNICPP
" =======
set tags+=~/.vim/tags/cpp
command! MkTags :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_NamespaceSearch     = 2 " 2: included 1: this file only
let OmniCpp_ShowAccess          = 1
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0
let OmniCpp_SelectFirstItem     = 0
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot      = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow    = 0 " autocomplete after ->
let OmniCpp_MayCompleteScope    = 0 " autocomplete after ::
let OmniCpp_DefaultNamespaces   = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" change between headers and definitions (.c to .h and biseversa)
nnoremap <Leader>< :A<CR>

let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1

" ==========
"  SNIPPETS
" ==========
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-b>"
let g:UltiSnipsEditSplit           = "vertical"
let g:snips_author                 = "Nicolas J. Salazar E."

" ================
" YOU COMPLETE ME
" ================
let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:ycm_global_ycm_extra_conf        = '~/.local/share/nvim/site/.ycm_extra_conf.py'

" =====
" MUNDO
" =====
let g:mundo_width = 60
let g:mundo_right = 0
let g:mundo_preview_height = 40
nnoremap <Leader>m :MundoToggle<CR>

" ==========
" EASY ALING
" ==========
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ ']': {
\     'pattern':       '\]\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       ')\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ 'f': {
\     'pattern': ' \(\S\+(\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   },
\ 'd': {
\     'pattern': ' \ze\S\+\s*[;=]',
\     'left_margin': 0,
\     'right_margin': 0
\   }
\ }

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ===
" ALE
" ===
let g:ale_lint_on_text_changed = 'never'
let g:ale_cpp_clangcheck_options = '-extra-arg=-std=c++17'
let g:ale_linters = {
            \ 'cpp': ['clang-format', 'clangtidy'],
            \ 'python': ['autopep8'],
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \}

let g:ale_python_pylint_executable = 'pylint3'
call extend(g:ale_linters, {
            \'python': ['flake8'], })
let g:ale_cpp_clangtidy_checks = ['*']
let g:airline#extensions#ale#enabled = 1
let g:ale_type_map = {'flake8': {'ES': 'WS', 'E': 'W'}}
let g:ale_sign_error=''
let g:ale_sign_warning=''
hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning

" ====
" GIT
" ====
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" Git Extentions
" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

" =====
" GRVIM
" =====
nmap <F4> :GRBuildProject<CR>
nmap <F5> :GRInstallProject<CR>
nmap <F6> :GRUninstallProject<CR>
nmap <F7> :GRRunTestProject<CR>

" =========
" NERD-TREE
" =========
let g:nerdtree_tabs_autoclose      = 0
let g:NERDSpaceDelims              = 1
let g:NERDDefaultAlign             = 'left'
let g:NERDTreeDirArrowExpandable   = '▸'
let g:NERDTreeDirArrowCollapsible  = '▾'
let g:NERDTreeChDirMode            = 2
let g:NERDTreeIgnore               = ['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder            = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:nerdtree_tabs_focus_on_files = 1
let g:NERDTreeWinSize              = 25

" Open and close NERDTree in the dir of current file
let g:NERDTree_Find_Toggle = 0
function! s:NERDTreeFindToggle()
  if g:NERDTree_Find_Toggle 
    execute "NERDTreeClose"
    let g:NERDTree_Find_Toggle = 0
  else
    execute "NERDTreeFind"
    let g:NERDTree_Find_Toggle = 1
  endif
endfunction

nnoremap <silent> <F10> :call <SID>NERDTreeFindToggle()<CR>

let g:tagbar_nerdtree_open_Toggle = 0
function! s:TagbarNERDTreeToggle()
  if g:tagbar_nerdtree_open_Toggle
    execute "NERDTreeClose | TagbarClose"
    let g:tagbar_nerdtree_open_Toggle = 0 
  else 
    execute "NERDTreeFind | wincmd p | TagbarOpen" 
    execute "wincmd p"
    let g:tagbar_nerdtree_open_Toggle = 1 
  endif
endfunction

nnoremap <silent><F8> :call <SID>TagbarNERDTreeToggle()<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') 
      \ && b:NERDTree.isTabTree() | quit | endif

" =====
" Latex
" =====
set conceallevel=1
let g:tex_flavor              = 'latex'
" let g:vimtex_view_method    = 'okular'
let g:vimtex_quickfix_mode    = 0
let g:tex_conceal             = 'abdmg'
let g:vimtex_version_check    = 0
let g:vimtex_mappings_enabled = 1

nmap <Leader>lv <plug>(vimtex-view)
nmap <Leader>ll <plug>(vimtex-compile)
nmap <Leader>lo <plug>(vimtex-compile-output)
nmap <Leader>lc <plug>(vimtex-clean)
nmap <Leader>lC <plug>(vimtex-clean-full)

" open inkscape via asyncrun.vim plug
command! Ink execute "AsyncRun inkscape"
nmap <Leader>li :Ink<CR>

" ======
" TAGBAR
" ======
nmap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" ==========
" INDENTLINE
" ==========
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┊'
let g:indentLine_faster = 1

" ===
" FZF
" ===
" let g:fzf_layout = { 'down': '25%' }
let g:fzf_layout = {'up':'~90%', 'window':
      \ { 'width':0.8, 'height':0.8,'yoffset':0.5,'xoffset':0.5, 'highlight':'Normal', 'border': 'sharp' } }
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-h': 'split',
      \ 'ctrl-v': 'vsplit',}

nnoremap <silent> <C-p> :<C-u>Files<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fg :Commits<CR>
"Recovery commands from history through FZF
nmap <Leader>fh :History:<CR>

" ========
" FLOATERM
" ========
nnoremap <silent> <F12> :FloatermToggle<CR>
tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

" =============
" NERDCOMMENTER
" =============
let g:NERDCreateDefaultMappings  = 1
let g:NERDSpaceDelims            = 1
let g:NERDCompactSexyComs        = 1
let g:NERDAltDelims_java         = 1
let g:NERDCommentEmptyLines      = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines    = 1
let g:NERDDefaultAlign           = 'left'
let g:NERDCustomDelimiters       = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCustomDelimiters       = { 'h': { 'left': '/**','right': '*/' } }
let g:NERDCustomDelimiters       = { 'cpp': { 'left': '/**','right': '*/' } }
let g:NERDCustomDelimiters       = { 'java': { 'left': '/**','right': '*/' } }

" ============
" VIM-SESSIONS
" ============
let g:session_directory       = "~/.vim/session"
let g:session_autoload        = "no"
let g:session_autosave        = "no"
let g:session_command_aliases = 1

nnoremap <Leader>so :OpenSession<Space>
nnoremap <Leader>ss :SaveSession<Space>
nnoremap <Leader>sd :DeleteSession<CR>
nnoremap <Leader>sc :CloseSession<CR>

" ================
" OPEN-BROWSER.VIM
" ================
let g:openbrowser_search_engines = extend(
\ get(g:, 'openbrowser_search_engines', {}),
\ {
\   'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
\   'qt': 'https://doc.qt.io/qt-5/search-results.html?q={query}',
\   'github': 'https://github.com/search?q={query}',
\ },
\ 'keep'
\)

nnoremap <silent> <Leader>osx :call openbrowser#smart_search(expand('<cword>'), "cppreference")<CR>
nnoremap <silent> <Leader>osq :call openbrowser#smart_search(expand('<cword>'), "qt")<CR>
nnoremap <silent> <Leader>osg :call openbrowser#smart_search(expand('<cword>'), "github")<CR>

command! GNURadioDoc OpenBrowser https://www.gnuradio.org/doc/doxygen/
command! GNURadioWiki OpenBrowser https://wiki.gnuradio.org/index.php/Main_Page
command! GNURadio OpenBrowser https://www.gnuradio.org/
command! GNURadioVolk OpenBrowser https://www.libvolk.org/doxygen/

" augroup cpp_doc
"   autocmd FileType cpp nnoremap K :FloatermNew cppman <cword><CR>
" augroup end

" =============
" JAVACOMPLETE2
" =============
augroup vimrc_java
    autocmd!
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
          \| imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
          \| imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
    autocmd FileType java imap <F5> <Plug>(JavaComplete-Imports-Add)
    autocmd FileType java imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    autocmd FileType java imap <F12> :Run<CR>
augroup END

let g:JavaComplete_EnableDefaultMappings = 1
