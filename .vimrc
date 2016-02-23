filetype off
set nocompatible
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'scrooloose/syntastic'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
"
" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'klen/python-mode' " Note: disable rope to avoid conflicts with jedi-vim
" Plugin 'Shougo/neocomplcache.vim'
"
" C/C++
Bundle 'Rip-Rip/clang_complete'
" BUG: clang_complete in combination with supertab inserts
"      "HandlePossibleSelectionEnter" on Enter in insert mode. No known fix (?)
"      according to https://github.com/Rip-Rip/clang_complete/issues/431
"      Temporary fix: Checkout clang_complete-version from Oct 24:
"          https://github.com/Rip-Rip/clang_complete/commit/6a7ad8249a209ad90b9f95e4611e911fb1339a32
"      i.e:
"          $ cd ~/dotfiles/.vim/bundle/clang_complete
"          $ git checkout 6a7ad8249a209ad90b9f95e4611e911fb1339a32
"
call vundle#end()
filetype plugin indent on

" colorscheme zenzike
set background=dark
colorscheme jellybeans  " https://github.com/nanotech/jellybeans.vim

augroup vim_resized
    au!
    au VimResized * exe "normal! \<c-w>="
augroup END

" Make sure Vim returns to the same line when you reopen a file.
" From https://www.youtube.com/watch?v=xZuy4gBghho
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

set t_Co=256
syntax on
set modelines=0
set expandtab
let mapleader = ","
let maplocalleader = "\\"

set tabpagemax=100

" NERDTree
nnoremap <leader>T :NERDTreeToggle<CR>
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapOpenVSplit='v'
let g:NERDTreeIgnore = ['\.pyc$']

" Neo
" let g:neocomplcache_enable_at_startup = 0
" let g:neocomplcache_enable_ignore_case = 0

" Supertab
set completeopt=longest,menu,menuone
set completeopt-=preview
" let g:SuperTabDefaultCompletionType='<c-p>'
" let g:SuperTabContextDefaultCompletionType = ''
" let g:SuperTabDefaultCompletionType='context'
let g:SuperTabMappingForward = '<nul>'
let g:SuperTabMappingBackward = '<s-nul>'
let g:SuperTabDefaultCompletionType = '<c-x><c-u>'  " Probably <c-o>

" jedi-vim
let g:jedi#auto_initialization = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = ""
let g:jedi#usages_command = "<leader>g"
let g:jedi#completions_command = ""   " inoremap <c-space> instead to get <c-x><c-o> behaviour
let g:jedi#completions_enabled = 1
let g:jedi#rename_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0  " If this doesn't work in some contexts, patch jedi#do_popup_on_dot_in_highlight() in jedi.vim to always return 0

" Python-mode
" checkout master branch if pymode is slow
let g:pymode_rope = 0 " Note: disable rope to avoid conflicts with jedi-vim
let g:pymode = 1

" " K             Show python docs
" " <Ctrl-Space>  Rope autocomplete
" " <Ctrl-c>g     Rope goto definition
" " <Ctrl-c>d     Rope show documentation
" " <Ctrl-c>f     Rope find occurrences
" " <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" " [[            Jump on previous class or function (normal, visual, operator modes)
" " ]]            Jump on next class or function (normal, visual, operator modes)
" " [M            Jump on previous class or method (normal, visual, operator modes)
" " ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_doc = 0
let g:pymode_run = 0
let g:pymode_doc_key = 'K'
let g:pymode_lint = 1
let g:pymode_lint_checkers = ["pep8","pyflakes"]
let g:pymode_lint_write = 1 " Auto check on save
augroup pymode_lint
    au!
    au BufWriteCmd *.py write || :PymodeLint  " Since the above intermittently stops working
augroup END
let g:pymode_virtualenv = 1
let g:pymode_breakpoint = 0
" let g:pymode_breakpoint_key = '<leader>b'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
" let g:pymode_syntax_builtin_types = g:pymode_syntax_all
let g:pymode_syntax_highlight_self = g:pymode_syntax_all
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding = 1
let g:pymode_lint_ignore="E114,E116" " For :PymodeLintAuto etc. to work, this must be defined even if it is an empty string.
" E114 indentation is not a multiple of four (comment) [pep8]
" E116 unexpected indentation (comment) [pep8]
let g:pymode_indent = 1
let g:pymode_motion = 1
let g:pymode_doc = 1
let g:pymode_options_max_line_length = 79
" let g:pymode_run_bind =
" let g:pymode_doc_bind = "K"

" " YouCompleteMe
" nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" " Syntastic
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['java', 'python'] }
" let g:syntastic_check_on_open=1
" let g:syntastic_enable_signs=1

" gitgutter
let g:gitgutter_live_mode = 1
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_max_signs = 1000
highlight clear SignColumn
highlight clear GitGutterAdd
highlight clear GitGutterChange
highlight clear GitGutterDelete
highlight clear GitGutterChangeDelete
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=4
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=1


augroup filetype_conf_python
    au!
    au BufNewFile,BufRead *.conf set syntax=python
augroup END

" <C-q> to gq} and return to position
" Catch <C-q> and <C-s>
silent !stty -ixon > /dev/null 2>/dev/null
nnoremap <C-q> mfgq}`f
inoremap <C-q> <esc>gq}gi

nnoremap <C-w><C-c> <nop>
nnoremap <C-w>c <nop>

" Swap adjacent words
nnoremap <silent> gE mf:set hls!<CR>"_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>:exe ":silent! normal /$.^\r"<CR>:set hls!<CR><c-o><c-l>`f
nnoremap <silent> gW mf:set hls!<CR>"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR>:exe ":silent! normal /^.$\r"<CR>:set hls!<CR><c-l>`f

command! W windo w

" nnoremap <space> @q

" Low delay in switching modes
set ttimeoutlen=50

nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

" Colorcolumn
set textwidth=79
if version >= 703
    set colorcolumn=80
    highlight ColorColumn ctermbg=darkgray ctermfg=black
endif

" set cursorline
" cul for active window only
" hi CursorLine ctermbg=0
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

"Folding
set foldmethod=indent
set foldnestmax=3
" set nofoldenable          " don't fold by default
set foldlevel=3
" Close all nonlocal folds
nnoremap <leader>z mzzMzvzz15<c-e>`z

" " Source the vimrc file after saving it
" if has("autocmd")
" 	autocmd bufwritepost .vimrc source $MYVIMRC
" endif
nmap <leader>v :tabedit $MYVIMRC<CR>

" Toggle mouse with <leader>m
set mouse=  " Default disabled
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
" set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set lazyredraw
set wildmode=list:longest
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
"set relativenumber
"set undofile

nnoremap / /\v
vnoremap / /\v
" set ignorecase
" set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

inoremap <C-c> <Esc><Esc>
vnoremap <C-c> <Esc><Esc>
nnoremap <C-c> <Esc><Esc>

" Avoid closing windows. Not sure why the above doesn't cover this.
nnoremap <C-w><C-c> <Esc><Esc>

nnoremap ]e <C-w><C-w>j<cr>
nnoremap [e <C-w><C-w>k<cr>

" nnoremap <tab> %
" vnoremap <tab> %
" imap <tab> <c-n>
" imap <tab> <c-x><c-o>
" imap <s-tab> <c-p>
" imap <c-tab> <c-x><c-o>
inoremap <c-space> <c-x><c-o>
inoremap <c-@> <c-x><c-o>

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

" nnoremap ' `
" nnoremap ` '

" arrow keys -> window resize
nnoremap <left> :vertical resize -5<cr>
nnoremap <down> :resize +5<cr>
nnoremap <up> :resize -5<cr>
nnoremap <right> :vertical resize +5<cr>

" <leader>t to jump to previously active tab
let g:lasttab = 1
nmap <leader>t :exe "tabn ".g:lasttab<CR>
augroup tab_leave
    au!
    au TabLeave * let g:lasttab = tabpagenr()
augroup END


" Don't move on * #
nnoremap * *<c-o>
nnoremap * maMmb`a*<c-o>`bzz`a
nnoremap # #<c-o>

" cp{motion} - change and paste.
" Mainly helps when you want to d{motion}c{motion}C-r",
"  which would otherwise just paste whatever was (c)hanged instead of (d)eleted.
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction

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
hi def InterestingWord7 guifg=#000000 ctermfg=16 guibg=#ff0000 ctermbg=200
hi def InterestingWord8 guifg=#000000 ctermfg=16 guibg=#ffff00 ctermbg=140
hi def InterestingWord9 guifg=#000000 ctermfg=16 guibg=#00ffff ctermbg=185
hi def InterestingWord0 guifg=#000000 ctermfg=16 guibg=#ffffff ctermbg=240
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
nnoremap <silent> <leader>7 :call HiInterestingWord(7)<cr>
nnoremap <silent> <leader>8 :call HiInterestingWord(8)<cr>
nnoremap <silent> <leader>9 :call HiInterestingWord(9)<cr>
nnoremap <silent> <leader>0 :call HiInterestingWord(0)<cr>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" nnoremap ; :

set number
set nowrap

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

augroup diff_update
    au!
    autocmd BufWritePost * if &diff == 1 | diffupdate | endif
augroup END

nnoremap <c-l> :call gitgutter#all()<CR>

"map <F9> :cprev<CR>
"map <F10> :cnext<CR>
"map <F11> :clist<CR>

"set spelllang=sv
set backup
set backupdir=~/.vimswp
set directory=$HOME/.vimswp//

" Ctrl-P
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.bmp
set wildignore+=*/.git/*
nnoremap <leader>p :call Control_P()<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
function! Control_P()
    if expand('%:p') =~ "tajitsu" || $PWD =~ "tajitsu"
        :CtrlP ~/src/tajitsu
    else
        :CtrlP $pwd
    endif
endfunction

" Let gq know PEP8 docstring textwidth (72 chars). Far from perfect. From
" http://stackoverflow.com/questions/4027222/vim-use-shorter-textwidth-in-comments-and-docstrings
function! GetPythonTextWidth()
    if !exists('g:python_normal_text_width')
        let normal_text_width = 79
    else
        let normal_text_width = g:python_normal_text_width
    endif
    if !exists('g:python_comment_text_width')
        let comment_text_width = 72
    else
        let comment_text_width = g:python_comment_text_width
    endif
    let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    if cur_syntax == "Comment"
        return normal_text_width  " allow comments to be wide for now
        " return comment_text_width
    elseif cur_syntax == "String"
        " Check to see if we're in a docstring
        let lnum = line(".")
        while lnum >= 1 && (synIDattr(synIDtrans(synID(lnum, col([lnum, "$"]) - 1, 0)), "name") == "String" || match(getline(lnum), '\v^\s*$') > -1)
            if match(getline(lnum), "\\('''\\|\"\"\"\\)") > -1
                " Assume that any longstring is a docstring
                return comment_text_width
            endif
            let lnum -= 1
        endwhile
    endif
    return normal_text_width
endfunction
augroup pep8
    au!
    autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
augroup END

"    "" Neo / clang_complete
"    let g:neocomplcache_force_overwrite_completefunc = 1
"    let g:neocomplcache_force_omni_patterns.c =
"          \ '[^.[:digit:] *\t]\%(\.\|->\)'
"    let g:neocomplcache_force_omni_patterns.cpp =
"          \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"    let g:neocomplcache_force_omni_patterns.objc =
"          \ '[^.[:digit:] *\t]\%(\.\|->\)'
"    let g:neocomplcache_force_omni_patterns.objcpp =
"          \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"    let g:clang_complete_auto = 0
"    let g:clang_auto_select = 0

"    let g:syntastic_cpp_compiler = 'g++'
"    let g:syntastic_cpp_compiler_options = ' -std=c++11'
"    " let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" clang_complete
let g:clang_library_path = '/usr/lib/'
let g:clang_use_library = 1
let g:clang_complete_copen = 1
let g:clang_complete_hl_errors = 1
let g:clang_periodic_quickfix = 1
let g:clang_trailing_placeholder = 1
let g:clang_close_preview = 1
let g:clang_snippets = 1
let g:clang_conceal_snippets=1
nmap <leader>c :w<CR>:call g:ClangUpdateQuickFix()<CR>
augroup clangupdatequickfix
    au!
    au BufWritePost * if (&ft == 'c' || &ft == 'cpp') | call g:ClangUpdateQuickFix() | endif
augroup END

augroup supertabchain
    au!
    autocmd BufEnter * call SuperTabChain(&omnifunc, "<c-p>")
augroup END
