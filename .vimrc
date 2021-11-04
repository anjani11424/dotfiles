call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips' 
Plug 'unblevable/quick-scope'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'gruvbox-community/gruvbox'

" Initialize plugin system
call plug#end()

"==============================================================================
" Settings
"==============================================================================
set iskeyword+=-           " treat dash separated words as a word text object"
set foldmethod=manual      " syntax highlighting items specify folds
set foldcolumn=0           " defines 1 col at window left, to indicate folding
set foldlevelstart=99      " start file with all folds opened
set scrolloff=5            " maintain some context
set hlsearch               " highlights matching search
set noshowmode            " No need when airline is used
set clipboard=unnamedplus " global clipboard
set incsearch             " incremental search,cursor follows matching.
set showmatch             " Matching paranthesis etc..
set ignorecase            " ignore case while searching
set smartcase             " Strict when both cases used
set shiftwidth=2          " Change no of spaces  inserted for indentation
set expandtab             " Converts tabs to spaces
set smartindent           " Makes indenting smart
set autoindent            " Good auto indent
set laststatus=2          " Always display the status line
set number                " Line numbers
set relativenumber        " Relative Line numbers
" set mouse=a               " Enable your mouse
set splitbelow            " Horizontal splits will automatically be below
set splitright            " Vertical splits will automatically be to the right
set updatetime=700        " Faster updations
set signcolumn=auto
set formatoptions-=o      " Stop newline continution of comments

" make spaces,tabs etc visible
" To enable this use set list
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Format the status line
" set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ \ %l:%c

if &diff
   set diffopt+=iwhite
   set diffexpr=DiffW()
endif

" =============== REMAPS =====================

inoremap <silent> <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Clear current word
nnoremap cw ciw

" Better indenting
vnoremap < <gv
vnoremap > >gv

vnoremap " f"
vmap ) f)

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

"select text that you just pasted
nnoremap gV `[v`]

" greatest remap ever
vnoremap <leader>p "_dP

nnoremap <silent> <space> :nohlsearch<CR>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Line number colouring - lite colors
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE


" file based settings
autocmd BufRead,BufNewFile *.yaml setlocal tabstop=2 shiftwidth=2 expandtab
" autocmd BufRead,BufNewFile *.py setlocal tabstop=4 shiftwidth=4 expandtab
autocmd BufRead,BufNewFile *.c setlocal tabstop=3 shiftwidth=3 expandtab foldmethod=syntax
autocmd BufRead,BufNewFile *.cpp setlocal tabstop=3 shiftwidth=3 expandtab foldmethod=syntax
autocmd BufRead,BufNewFile *.js setlocal shiftwidth=3 expandtab foldmethod=syntax

" Auto open all files when opening
autocmd BufWinEnter * silent! :%foldopen!


" ====================== FUNCTIONS =======================

" Vimdiff mode related changes
function! DiffW()
  let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-w " " swapped vim's -b with -w
   endif
   silent execute "!diff -a --binary " . opt .
     \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction

" To grab visually selected area
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


source "$HOME/.vim/fzf_map.vim"
source "$HOME/.vim/others.vim"
