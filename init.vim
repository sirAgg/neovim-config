let mapleader=" "

call plug#begin('~/.vim/plugged')

" This causes serious performace problems with large tags file
"Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'sainnhe/gruvbox-material'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'jiangmiao/auto-pairs'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
"Plug 'kien/ctrlp.vim'
"Plug 'JazzCore/ctrlp-cmatcher'

"Plug 'cpiger/NeoDebug'

Plug 'vim-airline/vim-airline'
Plug 'enricobacis/vim-airline-clock'
Plug 'tikhomirov/vim-glsl'

Plug 'skywind3000/asyncrun.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
"Plug 'vim-scripts/gtags.vim'

"Plug 'neovim/nvim-lsp'

Plug 'vim-syntastic/syntastic'
"Plug 'nvie/vim-flake8'

call plug#end()

let python_highlight_all=1

"let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_max_files = 0

set statusline+=%{gutentags#statusline('[',']')}

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

set guifont=Consolas:h9
 
nnoremap <leader>v :vs<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader>a za

"let g:ctrlp_map='<leader>e'
"nnoremap <leader>r :CtrlPBuffer<Enter>
"nnoremap <leader>t :CtrlPTag<Enter>

nnoremap <leader>e :Telescope git_files theme=ivy<Enter>
nnoremap <leader>r :Telescope buffers theme=ivy<Enter>
nnoremap <leader>t :Telescope tags theme=ivy only_sort_tags=true<Enter>

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

tnoremap <C-Esc> <C-\><C-n>

nnoremap <C-F12> :e ~\AppData\Local\nvim\init.vim<cr>

command! W w

colo gruvbox-material
let g:airline_theme='gruvbox_material'
"colo dracula
"let g:airline_theme='dracula'

let g:netrw_banner=0
let g:netrw_winsize=10
let g:netrw_liststyle=3

let g:highlighter#project_root_signs = ['.git']
let g:highlighter#auto_update = 2

let g:gutentags_modules = ['ctags', 'gtags_cscope'] " enable gtags module
let g:gutentags_project_root = ['.root'] " config project root markers.
let g:gutentags_cache_dir = expand('~/.cache/tags') " generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_plus_switch = 1 " change focus to quickfix window after search (optional).
let g:gutentags_define_advanced_commands = 1

function ReadProjSettings()
    if filereadable(".proj.vim")
        so .proj.vim
    endif
endfunction

autocmd VimEnter * call ReadProjSettings()

fun! Runcmd(cmd)
    silent! exe "noautocmd botright pedit ".a:cmd
    noautocmd wincmd P
    set buftype=nofile
    exe "noautocmd r! ".a:cmd
    noautocmd wincmd p
endfun
com! -nargs=1 Runcmd :call Runcmd("<args>")


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

":lua << EOF
"require'nvim_lsp'.rust_analyzer.setup{}
"EOF

"require'nvim_lsp'.clangd.setup{}

"set omnifunc=lsp#omnifunc

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\\.", "_", "g")
  "echo gatename
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

function! s:insert_include()
  let gatename = expand("%:t:r") . ".h"
  if(filereadable(expand("%:h") . "/" . gatename))
      execute "normal! i#include \"" . gatename . "\""
      normal! kk
  endif
endfunction
autocmd BufNewFile *.{c,cpp,cc} call <SID>insert_include()

let g:run_program_split_vertical=0
let g:buffnr = -1
function RunProgram(path_arg)
    if(g:buffnr < 0 || !bufexists(g:buffnr))
        if(g:run_program_split_vertical==0)
            execute '10sp'
        else
            execute '100vs'
        endif
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

function ToggleHeader()
    let type = expand("%:e")
    if type=="h"
        if filereadable(expand("%:r") . ".cc")
            :e %:r.cc
        elseif filereadable(expand("%:r") . ".cpp")
            :e %:r.cpp
        else
            :e %:r.c
        endif
    elseif type=="cc"
        :e %:r.h
    elseif type=="cpp"
        :e %:r.h
    elseif type=="c"
        :e %:r.h
    endif
endfunction

nnoremap <leader>m :call ToggleHeader()<cr>

lua << EOF

local actions = require "telescope.actions"
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
       i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          ["<C-w>"] = { "<c-s-w>", type = "command" },
          ["<esc>"] = actions.close,
        },
--
--        n = {
--          ["<esc>"] = actions.close,
--          ["<CR>"] = actions.select_default,
--          ["<C-x>"] = actions.select_horizontal,
--          ["<C-v>"] = actions.select_vertical,
--          ["<C-t>"] = actions.select_tab,
--
--          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
--          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
--          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
--          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
--
--          -- TODO: This would be weird if we switch the ordering.
--          ["j"] = actions.move_selection_next,
--          ["k"] = actions.move_selection_previous,
--          ["H"] = actions.move_to_top,
--          ["M"] = actions.move_to_middle,
--          ["L"] = actions.move_to_bottom,
--
--          ["<Down>"] = actions.move_selection_next,
--          ["<Up>"] = actions.move_selection_previous,
--          ["gg"] = actions.move_to_top,
--          ["G"] = actions.move_to_bottom,
--
--          ["<C-u>"] = actions.preview_scrolling_up,
--          ["<C-d>"] = actions.preview_scrolling_down,
--
--          ["<PageUp>"] = actions.results_scrolling_up,
--          ["<PageDown>"] = actions.results_scrolling_down,
--
--          ["?"] = actions.which_key,
--        }, 
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

require('telescope').load_extension('fzf')


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  --ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

EOF
