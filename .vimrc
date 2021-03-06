set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add plugins here

" https://vimawesome.com/plugin/python-syntax-please-everybody
Plugin 'vim-python/python-syntax'


" gruvbox color theme
Plugin 'morhetz/gruvbox'

" better C/C++ highlighting
Plugin 'octol/vim-cpp-enhanced-highlight'

" Plugin 'lyuts/vim-rtags'

" Plugin GNU assembler syntax highlighting
Plugin 'ClaytonKnittel/vim-gas'

Plugin 'tikhomirov/vim-glsl'
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

Plugin 'brgmnn/vim-opencl'
autocmd! BufNewFile,BufRead *.cl set ft=opencl


" Syntax highlighting for plist files
autocmd! BufNewFile,BufRead *.plist set ft=xml

" Default .h files to C++ syntax
autocmd! BufNewFile,BufRead *.h set ft=cpp

" Syntax highlighting for assembly files
autocmd! BufNewFile,BufRead *.s set ft=gas

let g:python_version_2 = 1

call vundle#end()
filetype plugin indent on
syntax on
set t_Co=256

set mouse=a
filetype plugin indent on
set tabstop=4
set shiftwidth=4
" set expandtab
set backspace=indent,eol,start
set ruler

set hlsearch

" for detecting italics escape code
"set t_ZH=^[[3m
"set t_ZR=^[[23m
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

colorscheme gruvbox
set bg=dark

highlight Comment cterm=italic

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


inoremap {<CR> {<CR>}<Esc>O

" Ctrl-g deletes next word
nnoremap <C-g> dw
inoremap <C-g> <Esc>ldwi

" jump to end of line in insert mode
inoremap <C-e> <C-o>$


" clang-format
" map <C-I> :py3f ~/.vim/clang-format.py<cr>
" imap <C-I> <c-o>:py3f ~/.vim/clang-format.py<cr>

function FormatBuffer()
  if !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

map <C-K> :call FormatBuffer()<cr>
imap <C-K> <c-o>:call FormatBuffer()<cr>

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

