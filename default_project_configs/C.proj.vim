" compile and run commands
nnoremap <f3> :wa<cr>:silent! cexpr system("make -C build")<cr>:copen<cr>G
nnoremap <S-f3> :wa<cr>:silent! cexpr system("make -C build clean & make -C build")<cr>:copen<cr><cr>G
nnoremap <f4> :call RunProgram("bin/c_test/Debug/c_test")<cr>
nnoremap <f2> :wa<cr>:!premake/premake5 gmake<cr>:!premake/premake5 export-compile-commands<cr>

nnoremap <f8> :!nemo .<cr><cr>

let g:default_header_ext=".h"
let g:default_source_ext=".c"

"set errorformat=\ %#%f(%l\\\,%c):\ %m

command -nargs=1 SetExecutable call SetExe(<f-args>)

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|target|build|Build|bin|docs$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
