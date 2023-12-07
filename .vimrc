set nocompatible              " required
filetype off                  " required

set updatetime=300

call plug#begin()

" add plugins here

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" gruvbox color theme
Plug 'ClaytonKnittel/gruvbox'

" Bundle 'sonph/onehalf', {'rtp': 'vim/'}
"Bundle 'sonph/onehalf', {'rtp': 'vim/'}

" better C/C++ highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Plug 'lyuts/vim-rtags'

" Plug clang-format.py
Plug 'ClaytonKnittel/vim-clang-format-executor'

" Plug GNU assembler syntax highlighting
Plug 'ClaytonKnittel/vim-gas'

Plug 'tikhomirov/vim-glsl'
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

Plug 'brgmnn/vim-opencl'
autocmd! BufNewFile,BufRead *.cl set ft=opencl

Plug 'ClaytonKnittel/vim-metal'
autocmd! BufNewFile,BufRead *.metal set ft=metal

Plug 'HerringtonDarkholme/yats.vim'
autocmd! BufNewFile,BufRead *.ts,*.mts set ft=typescript

Plug 'MaxMEllon/vim-jsx-pretty'

Plug 'rust-lang/rust.vim'

Plug 'elixir-editors/vim-elixir'

Plug 'mhinz/vim-mix-format'
let g:mix_format_on_save = 1

Plug 'neovimhaskell/haskell-vim'
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
" let g:haskell_classic_highlighting = 1

Plug 'sdiehl/vim-ormolu'
autocmd BufWritePre *.hs :call RunOrmolu()

Plug 'sbdchd/neoformat'
let g:neoformat_try_node_exe = 1

" Syntax highlighting for plist files
autocmd! BufNewFile,BufRead *.plist set ft=xml

" Syntax highlighting for assembly files
autocmd! BufNewFile,BufRead *.s,*.S set ft=gas

" Syntax highlighting for objective-c files
autocmd! BufNewFile,BufRead *.m set ft=objc

let g:python_version_2 = 1

call plug#end()

filetype plugin indent on
syntax on
set t_Co=256

let g:mapleader=","
set ttymouse=xterm2
set mouse=a
filetype plugin indent on
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set ruler
set cursorline
set timeoutlen=250
set guicursor+=a:blinkon0

set hlsearch

let g:python_recommended_style=0

" for detecting italics escape code
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

try
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E/
endtry

set bg=dark
"if has('macunix')
"	colorscheme onehalfdark
"	let g:airline_theme='onehalfdark'
"else
"	colorscheme onehalflight
"	let g:airline_theme='onehalfdark'
"endif

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

" movement controls for insert mode
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" rustfmt
let g:rustfmt_autosave = 1
let g:rust_recommended_style = 0

" clang-format
function ClangFormatBuffer()
  if !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :exe "s/$//" | :exe ":%!clang-format --assume-filename=\"%\"" | call setpos('.', cursor_pos)
    if v:shell_error != 0
      execute "echo \"" . join(getline(1, '$'), '\n') . "\""
      undo
    endif
  endif
endfunction
function PrettierFormatBuffer()
  if !empty(findfile('.prettierrc*', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :exe "s/$//" | :exe ":%!clang-format --assume-filename=\"%\"" | call setpos('.', cursor_pos)
    if v:shell_error != 0
      execute "echo \"" . join(getline(1, '$'), '\n') . "\""
      undo
    endif
  endif
endfunction

map <C-F> :call ClangFormatBuffer()<cr>
imap <C-F> <c-o>:call ClangFormatBuffer()<cr>
autocmd BufWritePre *.h,*.hpp,*.c,*.cc,*.m :call ClangFormatBuffer()

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.mts,*.html,*.css,*.json,*.md,README,*.yaml,*.yml Neoformat

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

set vb t_vb= " no bell on tmux

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

"function! s:on_lsp_buffer_enabled() abort
"  setlocal omnifunc=lsp#complete
"  setlocal signcolumn=yes
"  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"
"  nmap <buffer> ga <plug>(lsp-code-action-float)
"  nmap <buffer> gd <plug>(lsp-definition)
"  nmap <buffer> gs <plug>(lsp-document-symbol-search)
"  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"  nmap <buffer> gr <plug>(lsp-references)
"  nmap <buffer> gi <plug>(lsp-implementation)
"  nmap <buffer> gt <plug>(lsp-type-definition)
"  nmap <buffer> gn <plug>(lsp-rename)
"  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"  nmap <buffer> K <plug>(lsp-hover)
"  " nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
"  " nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
"
"  let g:lsp_format_sync_timeout = 1000
"  autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
"  
"  " refer to doc to add more commands
"endfunction
"
"augroup lsp_install
"  au!
"  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"augroup END

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Enable undercurl for errors (kinda works)
set t_Cs="\<Esc>[4:3m"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap C-k in insert mode to close the CoC autocomplete window if open.
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#stop() : "\<C-k>"

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap gn <Plug>(coc-rename)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-cursor)
nmap <leader>a <Plug>(coc-codeaction-cursor)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" hi VertSplit cterm=NONE guibg=#e6e6e6
" hi StatusLine guibg=#d0d0d0
" hi StatusLineNC guibg=#e6e6e6

" hi CursorLine   cterm=NONE ctermbg=red ctermfg=white guibg=#e0e0e0 guifg=NONE

" Note: format comment: highlight comment, then gq

" let g:terminal_ansi_colors = [
"   \'#eeeeee', '#af0000', '#008700', '#5f8700',
"   \'#0087af', '#878787', '#005f87', '#444444',
"   \'#bcbcbc', '#d70000', '#d70087', '#8700af',
"   \'#d75f00', '#d75f00', '#005faf', '#005f87' ]

