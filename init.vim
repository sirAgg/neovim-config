let mapleader=" "

let g:tag_highlight#run_ctags=1
call plug#begin('~/.vim/plugged')

" This causes serious performace problems with large tags file
"Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'nvim-treesitter/nvim-treesitter'

Plug 'sainnhe/gruvbox-material'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'jiangmiao/auto-pairs'

Plug 'kien/ctrlp.vim'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'

Plug 'cpiger/NeoDebug'

Plug 'vim-airline/vim-airline'
Plug 'enricobacis/vim-airline-clock'
Plug 'tikhomirov/vim-glsl'

Plug 'rust-lang/rust.vim'

Plug 'vim-scripts/vim-misc'
Plug 'xolox/vim-easytags'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'jackguo380/vim-lsp-cxx-highlight'

"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
"Plug 'neovim/nvim-lsp'

call plug#end()

set nocompatible
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim " path to dein.vim
call dein#begin(expand("~/.vim/dein"))
call dein#add('roflcopter4/tag-highlight.nvim', {'merged': v:false, 'build': 'sh build.sh'})
"call dein#add('c0r73x/neotags.nvim', {'build': 'make'})
call dein#end()

syntax on
filetype plugin on
set hidden

set path+=**
set wildmode=longest,list,full
set wildmenu

set mouse=a

set cursorline

set tabstop=4
set expandtab
set shiftwidth=4

set fdm=syntax
set foldlevel=99

set splitbelow
set splitright

set clipboard+=unnamedplus
 
nnoremap <leader>v :vs<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader>a za

nnoremap <leader>e :CtrlP<cr>
nnoremap <leader>r :CtrlPBuffer<cr>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>y :CtrlPLine<cr>

nnoremap <leader><Enter> <C-^>

nnoremap <leader>d <C-]>zz
nnoremap <leader><S-d> :pop<cr>zz
nnoremap <leader>b :Lexplore<cr>

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>q <C-w>c
nnoremap <leader>x :cn<cr>
nnoremap <leader><Esc> :noh<cr>

nnoremap <F36> :e ~/.config/nvim/init.vim<cr>

tnoremap <C-Esc> <C-\><C-n>

au BufRead,BufNewFile *.ogge set filetype=ogge

command! W w

set termguicolors
colo gruvbox-material
let g:airline_theme='gruvbox_material'
"colo dracula
"let g:airline_theme='dracula'
"colo PaperColor
"let g:airline_theme='papercolor'
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

let g:netrw_banner=0
let g:netrw_winsize=10
let g:netrw_liststyle=3

let g:highlighter#project_root_signs = ['.git']
let g:highlighter#auto_update = 2

let g:easytags_async=1

autocmd FileType C let b:easytags_auto_highlight = 1
autocmd FileType C++ let b:easytags_auto_highlight = 1


" 
" Read project settings file
"
function ReadProjSettings()
    if filereadable(".proj.vim")
        so .proj.vim
    endif
endfunction

autocmd VimEnter * call ReadProjSettings()


"
" Tab complete
"
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>

"
" Insert gates and include statement when createing c and c++ files
"
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\\.", "_", "g")
  echo gatename
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

function! s:insert_include()
  if filereadable(expand("%:r") . ".h")
      let gatename = expand("%:t:r") . ".h"
  elseif filereadable(expand("%:r") . ".hpp")
      let gatename = expand("%:t:r") . ".hpp"
  endif

  if(filereadable(expand("%:h") . "/" . gatename))
      execute "normal! i#include \"" . gatename . "\""
      normal! kk
  endif
endfunction
autocmd BufNewFile *.{c,cpp,cc} call <SID>insert_include()


"
" Toggle header in c and c++
"
let g:default_header_ext=".h"
let g:default_source_ext=".c"
function ToggleHeader()
    let type = expand("%:e")
    if type=="h" || type=="hpp"
        if filereadable(expand("%:r") . ".cc")
            :e %:r.cc
        elseif filereadable(expand("%:r") . ".c")
            :e %:r.c
        elseif filereadable(expand("%:r") . ".cpp")
            :e %:r.cpp
        else
            execute "e " . expand("%:r") . g:default_source_ext
        endif
    elseif type=="cc" || type=="cpp"
        if filereadable(expand("%:r") . ".hpp")
            :e %:r.hpp
        elseif filereadable(expand("%:r") . ".h")
            :e %:r.h
        else
            execute "e " . expand("%:r") . g:default_header_ext
        endif
    elseif type=="c"
        :e %:r.h
    endif
endfunction
nnoremap <leader>m :call ToggleHeader()<cr>


"
" Run a program in nvim's terminal
"
let g:buffnr = -1
function RunProgram(path_arg)
    if(g:buffnr < 0 || !bufexists(g:buffnr))
        execute '10sp'
        execute 'terminal ' . a:path_arg
        let g:buffnr = bufnr('%')
    else
        let winnr = bufwinnr(g:buffnr)
        if(winnr > 0)
            execute winnr 'wincmd w'
            execute 'terminal ' . a:path_arg
        else
            execute '10sp'
            execute 'buffer ' . g:buffnr
            execute 'terminal ' . a:path_arg
        endif

        execute 'bdelete! ' . g:buffnr
        let g:buffnr = bufnr('%')
    endif
    execute "normal! a"
endfunction


function SetExe(file)
    let command = 'nnoremap <f4> :call RunProgram("bin/' . a:file . '")<cr>'
    execute command
endfunction
