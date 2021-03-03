filetype plugin indent on
syntax enable

" Turn on line number
set number

" Sets how many lines of history vim has to remember
set history=10000

" Set to auto read when a file is changed from the outside
set autoread

" Min width of the number column to the left
" set numberwidth=1

" Auto complete setting
set completeopt=longest,menuone
set wildmode=list:longest,full
set wildmenu                "turn on wild menu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

" Allow changing buffer without saving it first
set hidden
set confirm

" Case insensitive search
set ignorecase
set smartcase

" Set sensible heights for splits
"set winheight=40
" Setting this causes problems with Unite-outline. Don't really need it
"set winminheight=3

" Make search act like search in modern browsers
set incsearch

" Highlight all search matches
set hlsearch

" Make regex a little easier to type
set magic

" Don't show matching brackets
set noshowmatch

" Show incomplete commands
set showcmd

" Turn off sound
set vb
set t_vb=

" Always show the status line
set laststatus=2

" Explicitly set encoding to utf-8
set encoding=utf-8

" Column width indicator
" set colorcolumn=+1

" For faster InsertLeave triggering
set ttimeoutlen=50

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Tab settings
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab

set foldmethod=indent
set nofoldenable

set breakindent

" Text display settings.
set linebreak
set showbreak=↪
set nowrap
set whichwrap+=h,l,<,>,[,]

" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

set ffs=unix,dos,mac

" Disable showing of: Hit enter or type command to command to continue.
set sc nosc

" Use a low update time. This is used by CursorHold.
"set updatetime=1000

" Autosave & Load Views.
set viewoptions=folds,cursor
autocmd BufWritePost,BufLeave,WinLeave,BufWinLeave * if &modifiable && &ft!='denite' | silent! mkview | endif
autocmd BufWinEnter * if &modifiable && &ft!='denite' | silent! loadview | endif

" Spell-checking
" Add words to the dictionary by cursoring over those words in a file and
" typing: zg
set complete+=kspell
set spelllang=en,cs
set spell

" Search for tags file in upper directories until tags file found.
set tags=./tags;/

" Persistent undo
set undodir=~/.vim.undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

if has('nvim')
  set icm=nosplit
  set mouse=a
endif

set signcolumn=yes

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee %

" Allow to change permission before write.
cmap w!!! silent w !chmod +w %

" Scroll up and down without moving cursor position.
map <C-Up>   <C-y>
map <C-Down> <C-e>
inoremap <C-Up> <Esc><C-y>a
inoremap <C-Down> <Esc><C-e>a

" u   undo
" S-u redo
" C-u gundo
map <S-u> :redo<CR>

" Tab: Go to matching element
" Disabled for now because <Tab> is equal to <C-i> which I use heavily.
"nnoremap <Tab> %

" Press 'cd' to change directory to folder where currently open file is.
nnoremap cd :lcd %:p:h<bar>pwd<cr>

" Let PgUp and PgDown scroll up to first/last line.
nnoremap <pageup> <c-u><c-u>
nnoremap <pagedown> <c-d><c-d>

" Move cursor to different window by pressing ALT-Arrows.
nnoremap <A-Up> <C-w>k
nnoremap <A-Down> <C-w>j
nnoremap <A-Left> <C-w>h
nnoremap <A-Right> <C-w>l

" Easy exit from insert mode in terminal.
tnoremap <Esc> <C-\><C-n>

" Move cursor to different window by pressing ALT-Arrows in terminal.
tnoremap <A-Up> <C-\><C-n><C-w>k
tnoremap <A-Down> <C-\><C-n><C-w>j
tnoremap <A-Left> <C-\><C-n><C-w>h
tnoremap <A-Right> <C-\><C-n><C-w>l

" vmap - mapping for visual mode
"   _d - delete current selection into "black hole register"
"   P  - paste
vmap r "_dP

" Replace a word under cursor by pressing \s
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" The most accurate syntax highlighting.
autocmd BufEnter * :syntax sync fromstart

" Show marks columns even when there are no signs shown.
"autocmd BufEnter * sign define dummy
"autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

