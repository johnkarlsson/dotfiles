colorscheme zenzike

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" setlocal makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode\ $*\\\|\ grep\ \-E\ '\\w+:[0-9]{1,4}:\\\ ' 
" setlocal errorformat=%f:%l:\ %m 
" map <buffer> ,p :w<CR>:make %<<CR> 
"map ,p :w<CR>:!pdflatex % &<CR> 
au FileType tex map <silent> <expr> <leader>l system("pdflatex ".expand("%"))
au BufWritePost *.tex silent call system("pdflatex ".expand("%"))

au VimResized * exe "normal! \<c-w>="

augroup 

" Make sure Vim returns to the same line when you reopen a file.
" From https://www.youtube.com/watch?v=xZuy4gBghho
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

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

" <C-q> to gqip and return to position
" Catch <C-q> and <C-s>
silent !stty -ixon > /dev/null 2>/dev/null
nnoremap <C-q> mfgqip`f
inoremap <C-q> <esc>gqipgi

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
let g:airline_theme='simple'
let g:airline_powerline_fonts=0

" Colorcolumn
set textwidth=80
if version >= 703
    set colorcolumn=81
    highlight ColorColumn ctermbg=red ctermfg=black
endif

"Folding
set foldmethod=syntax
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable          " dont fold by default
set foldlevel=1
" Close all nonlocal folds
nnoremap <leader>z mzzMzvzz15<c-e>`z

" " Source the vimrc file after saving it
" if has("autocmd")
" 	autocmd bufwritepost .vimrc source $MYVIMRC
" endif
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

set splitright

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

nnoremap ' `
nnoremap ` '

" arrow keys -> window resize
nnoremap <left> :vertical resize -5<cr>
nnoremap <down> :resize +5<cr>
nnoremap <up> :resize -5<cr>
nnoremap <right> :vertical resize +5<cr>

au FocusLost * :wa

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap ]] ]]zt
nnoremap [[ [[zt
nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz
nnoremap <c-t> <c-t>zt

" Don't move on * #
nnoremap * *<c-o>
nnoremap # #<c-o>

" <leader>[1-6] to highlight words
function! HiInterestingWord(n) " {{{
    normal! mz
    normal! "zyiw
    let mid = 86750 + a:n
    silent! call matchdelete(mid)
    let pat = '\V\<' . escape(@z, '\') . '\>'
    call matchadd("InterestingWord" . a:n, pat, 1, mid)
    normal! `z
endfunction " }}}
hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

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

autocmd BufWritePost * if &diff == 1 | diffupdate | endif

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
"" Neo / clang_complete
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc =
      \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.objcpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

let g:clang_library_path = '/usr/lib/'
let g:clang_use_library = 1
let g:clang_complete_copen = 1
let g:clang_complete_hl_errors = 1
let g:clang_periodic_quickfix = 1
let g:clang_trailing_placeholder = 1
let g:clang_close_preview = 1
let g:clang_snippets = 1
let g:clang_conceal_snippets=1

set conceallevel=2
set concealcursor=
hi Conceal cterm=NONE ctermbg=NONE ctermfg=yellow
let g:tex_conceal="adgm"

" set completeopt=menu,menuone
let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'
nmap <leader>c :call g:ClangUpdateQuickFix()<CR>
