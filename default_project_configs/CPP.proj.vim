" compile and run commands
nnoremap <f3> :wa<cr>:silent! cexpr system("ninja -C build")<cr>:copen<cr>G
nnoremap <S-f3> :wa<cr>:silent! cexpr system("ninja -C build -t clean & ninja -C build")<cr>:copen<cr>G
nnoremap <f4> :call RunProgram("bin")<cr>
nnoremap <f2> :wa<cr>:!premake/premake5 gmake<cr>:!premake/premake5 export-compile-commands<cr>

nnoremap <f8> :!nemo .<cr><cr>

"set errorformat=\ %#%f(%l\\\,%c):\ %m

let g:default_header_ext=".hpp"
let g:default_source_ext=".cpp"

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|target|build|Build|bin|docs$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
