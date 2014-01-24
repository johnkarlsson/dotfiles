colorscheme zenzike

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" setlocal makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode\ $*\\\|\ grep\ \-E\ '\\w+:[0-9]{1,4}:\\\ ' 
" setlocal errorformat=%f:%l:\ %m 
" map <buffer> ,p :w<CR>:make %<<CR> 
"map ,p :w<CR>:!pdflatex % &<CR> 
au FileType tex map <silent> <expr> <leader>l system("pdflatex ".expand("%"))
au BufWritePost *.tex silent call system("pdflatex ".expand("%"))


" let b:tex_flavor = 'pdflatex' 
" compiler tex 

set background=dark

set t_Co=256
filetype off
syntax on
filetype plugin indent on
set nocompatible
set modelines=0
set expandtab
let mapleader = ","
let maplocalleader = "\\"


" Low delay in switching modes
set ttimeoutlen=50

nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
let g:airline_fugitive_prefix = '⎇  '
let g:airline_paste_symbol = 'ρ'
let g:airline_paste_symbol = 'Þ'
let g:airline_paste_symbol = '∥'
" TEST
let g:airline_theme='simple'
let g:airline_powerline_fonts=0

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" Colorcolumn
set textwidth=80
if version >= 703
    set colorcolumn=81
endif

"Folding
set foldmethod=indent   " fold based on indent
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable          " dont fold by default
set foldlevel=1

" Source the vimrc file after saving it
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif
nmap <leader>v :tabedit $MYVIMRC<CR>

" Toggle mouse with <leader>m
nnoremap <leader>m :call ToggleMouse()<CR>
function! ToggleMouse()
    if &mouse == 'a'
        set mouse=
        echo "Mouse usage disabled"
    else
        set mouse=a
        echo "Mouse usage enabled"
    endif
endfunction
 
" Delete?
au BufNewFile,BufRead *.as set filetype=javascript
au BufNewFile,BufRead *.ck setf ck  

set tabstop=4
set shiftwidth=4
set softtabstop=4

set list listchars=tab:→\ ,trail:·

set encoding=UTF-8
"set encoding=iso-8859-1
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
"set relativenumber
"set undofile

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

inoremap <C-c> <Esc><Esc>
vnoremap <C-c> <Esc><Esc>
nnoremap <C-c> <Esc><Esc>

" nnoremap <tab> %
" vnoremap <tab> %
imap <tab> <c-n>
imap <s-tab> <c-p>
imap <c-tab> <c-x><c-l>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" arrow keys -> window resize
nnoremap <left> :vertical resize -5<cr>
nnoremap <down> :resize +5<cr>
nnoremap <up> :resize -5<cr>
nnoremap <right> :vertical resize +5<cr>

au FocusLost * :wa

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" nnoremap ; :

set number
set nowrap

nmap <leader>R :RainbowParenthesesToggle<CR>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


let b:tex_flavor = 'pdflatex'
compiler tex
set makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode
set errorformat=%f:%l:\ %m

map <F11> :!xpdf %<.pdf &<CR>
map <F12> :w<CR>:make %<<CR>
"map <F9> :cprev<CR>
"map <F10> :cnext<CR>
"map <F11> :clist<CR>

set spelllang=sv
set backup
set backupdir=~/.vimswp

" For vim-R plugin
let vimrplugin_screenplugin = 0
set completeopt-=preview

" Neo
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 0
"" Neo / Eclim
let g:EclimCompletionMethod = 'omnifunc'
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.java = '\k\.\k*'

" Syntastic / Clang++
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Tags
set tags=tags;
