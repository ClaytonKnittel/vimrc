set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add plugins here

" gruvbox color theme
" Plugin 'morhetz/gruvbox'

Bundle 'sonph/onehalf', {'rtp': 'vim/'}
"Bundle 'sonph/onehalf', {'rtp': 'vim/'}

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

" Default .h files to C syntax
autocmd! BufNewFile,BufRead *.h set ft=c

" Syntax highlighting for assembly files
autocmd! BufNewFile,BufRead *.s set ft=gas

let g:python_version_2 = 1

call vundle#end()
filetype plugin indent on
syntax on
set t_Co=256

set ttymouse=xterm2
set mouse=a
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set noexpandtab
set backspace=indent,eol,start
set ruler
set cursorline

set hlsearch

let g:python_recommended_style=0

" for detecting italics escape code
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" colorscheme gruvbox
" set bg=dark
if has('macunix')
	colorscheme onehalfdark
	let g:airline_theme='onehalfdark'
else
	colorscheme onehalflight
	let g:airline_theme='onehalfdark'
endif

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

set vb t_vb= " no bell on tmux

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

hi VertSplit cterm=NONE guibg=#e6e6e6
hi StatusLine guibg=#d0d0d0
hi StatusLineNC guibg=#e6e6e6

" hi CursorLine   cterm=NONE ctermbg=red ctermfg=white guibg=#e0e0e0 guifg=NONE

