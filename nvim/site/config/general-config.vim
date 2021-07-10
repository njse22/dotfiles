" ==============
" GENERAL CONFIG
" ==============
set number										 " for enable the numbers in the editor
set numberwidth=4							 " for change the weigh of the numbers
set showcmd										 " show the command that you typing
set encoding=utf-8						 " chance the codification to UTF-8
set fileencodings=utf-8
set ttyfast
set backspace=indent,eol,start " Fix backspace indent
set clipboard=unnamed          " enable the clipboard at the OS
set sw=4                       " set the indented space
set softtabstop=2              " Indent by 2 spaces when hitting tab
set showmatch                  " higlinth match with the parenthesis, brackets,
set relativenumber             " position relative Del cursor
set laststatus=2               " show the status bar
set wildmenu                   " garage en deep liege de option's con tab
set cursorline                 " ability line sabre El cursor
set hlsearch                   " ability El resale ado en la busked
set incsearch
set ignorecase
set smartcase
set autoindent                 " Enable auto indenting
set modeline                   " Make sure vim checks for 'set commands' in opened files
set modelines=3
set noshowmode								 " quita el texto del modo actual
set colorcolumn=85
set updatetime=100
set path+=$PWD/**
set tags+=~/.local/share/nvim/site/tags;
set tags+=tags;
set nocompatible
filetype on										 " Enable the 'file type' in files... super description
filetype indent on						 " Enable indenting for files
filetype plugin indent on			 " Enable file type based indentation
syntax enable									 " Enable syntax highlighting
highlight CursorLine ctermbg=grey

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

let no_buffers_menu=1
runtime ftplugin/man.vim

" =================
" DEFINE LEADER KEY
" =================
let mapleader=","

" ===============
" CUSTOM MAPPING
" ===============

map <up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>

" open files in vertical and horizontal splits
map <Leader>v <C-w>vgf
map <Leader>h <C-w>f

" ====================
"  Normal Mode Mapping
" ====================

" terminal emulation
nnoremap <silent> <Leader>sh :terminal<CR>

" set working directory
nnoremap <Leader>. :lcd %:p:h<CR>

" search and replace
nnoremap <F3> :%s/<c-r><c-w>//gc<left><left><left>

nnoremap n nzzzv
nnoremap N Nzzzv

" common actions
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>q! :q!<CR>

" navigated between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-w>l

" navigated between tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <Leader>te :tabedit<cfile><CR>

" clear search matches
nnoremap <silent> <Leader> <space> :nohlsearch<CR>

" Define Custom macros
nnoremap mu :normal! ddkP<CR>
nnoremap md :normal! ddp<CR>
nnoremap u1 :normal! yypVr=<CR>
nnoremap u2 :normal! yyPVr=<CR>
nnoremap u3 :normal! yypVr=kPVr=<CR>
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel

" navigated in buffers
noremap <Leader>z :bp<CR>
noremap <Leader>x :bn<CR>
noremap <Leader>c :bd<CR>
command! Bda execute ":%bd|e#"
noremap <Leader>ca :Bda<CR>

" files
" nnoremap <C-p> :e<space>
" nnoremap <Leader>ft :tabedit<space>
" nnoremap <Leader>fv :vsplit<space>
" nnoremap <Leader>fs :split<space>
" nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" simple math
nnoremap \|m 0yt=A<C-r>=<C-r>"<CR>

" ===================
" Insert Mode Mapping
" ===================

" center cursor when the ESC key is pushed
inoremap <Esc> <Esc>zz

" uppercase word
inoremap <c-u> <esc>viwUi

" move with hjkl in Insert Mode
imap <A-k> <C-o>k
imap <A-j> <C-o>j
imap <A-l> <Right>
imap <A-h> <Left>

inoremap <A-a> <esc>a
inoremap <A-o> <esc>o

inoremap II <Esc>I
inoremap AA <Esc>A
inoremap OO <Esc>O

imap <up> <nop>
imap <Down> <nop>

" omnifunc maping
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" ================
" Visual Mode Mode
" ================

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ====================
" Command Mode Mapping
" ====================
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <A-l> <Right>
cnoremap <A-h> <Left>

let g:netrw_banner       = 0
let g:netrw_liststyle    = 3
let g:netrw_browse_split = 4
let g:netrw_altv         = 1
let g:netrw_winsize      = 25

" ==============
" AUTOCMD RULES
" ==============

" Remember cursor position
augroup vimrc_remember_cursor_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| exe "normal! g`\""
        \| endif
augroup END


augroup vimrc_remove_withespaces
    autocmd!
    highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+%#\@<!$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END

nnoremap <silent> <Leader>rs :let _s=@/
      \ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" =================
" CUSTOM FUNCTIONS
" =================

" Define grammar check
nnoremap <Leader>ñ :call <SID>SpellToggle()<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

let g:spell_checked = 0
function! s:SpellToggle()
    if !g:spell_checked
        set spell
        set spelllang=es,en
        let g:spell_checked = 1
    else
        set nospell
       let g:spell_checked = 0
    endif
endfunction

" custom find
nnoremap <Leader>s :call <SID>GrepSearchToggle(mode())<CR>
vnoremap <Leader>s :<c-u>call <SID>GrepSearchToggle(visualmode())<cr>

let g:grep_search_open = 0

function! s:GrepSearchToggle(type)
    let saved_unnamed_register = @@

    if g:grep_search_open
      cclose
      let g:grep_search_open = 0
    else
      if a:type ==# 'v'
          normal! `<v`>y
      elseif a:type ==# 'char'
          normal! `[v`]y
      elseif a:type ==# 'n'
          silent execute "grep! -R "
          \. shellescape(expand("<cWORD>")) .
          \" * --exclude-dir={.git,tmp,log}"
          set background=dark " this solve a little bug that I have with my background
          copen
          let g:grep_search_open = 1
          return
	else
	    return
	endif
	silent execute "grep! -R "
		    \. shellescape(expand(@@)) .
		    \" * --exclude-dir={.git,tmp,log}"
  set background=dark " this solve a little bug that I have with my background
	copen
	let g:grep_search_open = 1
    endif

    let @@ = saved_unnamed_register
endfunction

" wrapen
map <Leader>a :call ToggleWrap()<CR>

let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set textwidth=85
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    set textwidth=85
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction

let g:notes_dir = '~/ICESI/Noveno_Semestre/'
let g:notes_extention = '.tex'

function! Edit(...)
	let l:sep = ''
	if len(a:000) > 0
		let l:sep = '-'
	endif
	let l:fname = expand(g:notes_dir) .  strftime("%F-%H%M") .
              \ l:sep . join(a:000, '-') . g:notes_extention
	execute "e " . l:fname
endfunction
command! -nargs=* NoteNew call Edit(<f-args>)

function! s:CppClangFormat(first, last)
    let l:winview = winsaveview()
    " this is the clang format that I use ...
    let l:gnuradio_clang_format = '~/Software/pybombs/gr37/src/gnuradio/.clang-format'
    execute a:first . "," . a:last . '!clang-format -assume-filename='.
                \ l:gnuradio_clang_format .' -sort-includes=false -style=file '
    call winrestview(l:winview)
endfunction
command! -range=% CppClangFormat call <SID>CppClangFormat(<line1>, <line2>)

" ===========================
" CUSTOM CONFIGS FOR LANGUJES
" ===========================

" C/C++
augroup vimrc_c_cpp
    autocmd!
    autocmd FileType c,cpp,h setlocal tabstop=4 shiftwidth=4 expandtab
								 \| set keywordprg=cppman
                 \| nnoremap <buffer> <Leader> l :<C-u>CppClangFormat<CR>
                 \| nnoremap <F5> :make<CR>
                 \| vnoremap <buffer> <Leader> l :CppClangFormat<CR>
    autocmd FileType c,cpp,h
          \| :iabbrev #i #include
          \| :iabbrev #d #define
          \| :iabbrev /* /*<CR><CR>/<Up>
          \| :iabbrev forl for (i=1; i<=NUM; i++) {<CR><CR>}<Esc>?NUM<CR>cw
augroup END
autocmd BufEnter *.i  :set filetype=cpp " These are usually SWIG files for me
autocmd BufEnter Makefile* :set filetype=make
autocmd BufEnter *.lwr set filetype=yml

" HTML
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" javascript
augroup vimrc_javascript
  autocmd!
  autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

" python
augroup vimrc_python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=85
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  autocmd FileType python
      \ :iabbrev ppp print("");<left><left><left>
  autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
  autocmd FileType python imap <buffer> <F5> <esc>:w<ChhR>:exec '!python3' shellescape(@%, 1)<CR>
augroup END
let python_highlight_all = 1
