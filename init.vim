if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

Plug 'Shougo/defx.nvim'			" File Explorer

"Plug 'https://github.com/orokasan/denite.nvim.git', {'branch': 'develop'}
Plug 'Shougo/denite.nvim'		" Denite
Plug 'Shougo/neomru.vim'		" Denite Most Recently Used files / directories 
let g:neomru#do_validate = 0		" Automatically remove invalid file paths from MRU history
"Plug 'Shougo/deol.nvim'
tnoremap <ESC> <C-\><C-n>
Plug 'ozelentok/denite-gtags'		" Denite GTAGS
Plug 'kmnk/denite-dirmark'

set clipboard& clipboard+=unnamed
Plug 'https://github.com/Shougo/neoyank.vim.git'

Plug 'https://github.com/Shougo/vinarise.git' " hex editing
let g:vinarise_enable_auto_detect = 1

"Plug 'voldikss/vim-floaterm'
"noremap <silent> <F12> :FloatermToggle<CR>i
"tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>

" <C-W>m - zoom in and zoom out for current window
"Plug 'dhruvasagar/vim-zoom'
"set statusline+=%{zoom#statusline()}


" add	    	sa{motion/textobject}{addition}	(normal and visual mode)
"
" delete		sd			                	(visual mode)
" 	        	sdb		                		(normal mode)
" 	        	sd{deletion}	        		(normal mode)
"
" replace		sr{addition}		        	(visual mode)
" 	        	srb{addition}			        (normal mode)
" 		        sr{deletion}{addition}		    (normal mode)
"
" textobjct	    ib	                           (operator-pending and visual mode)
"   		    ab	                           (operator-pending and visual mode)
" 	    	    is                       	   (operator-pending and visual mode)
" 		        as			                   (operator-pending and visual mode)
Plug 'https://github.com/machakann/vim-sandwich.git'
nmap s <Nop>
xmap s <Nop>

Plug 'https://github.com/skywind3000/asyncrun.vim.git'
"   :AsyncRun ...command...
    nnoremap <F1> :AsyncRun g++ -O3 "%" -o "%<" -lpthread && ./"%<"<CR>

    func CloseQuickfix(timer)
        execute 'cclose'
    endfunc

    " Raises Unite quickfix window every time something is added to quickfix
    augroup vimrc
        autocmd User AsyncRunStop :copen
        autocmd User AsyncRunStop :call timer_start(10000, 'CloseQuickfix')
    augroup END

Plug 'mattn/vim-lsp-settings'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'

"Plug 'tsufeki/asyncomplete-fuzzy-match', { 'do': 'cargo build --release' }

"Plug 'luochen1990/rainbow'
"Plug 'frazrepo/vim-rainbow'
Plug 'junegunn/rainbow_parentheses.vim'
" Rainbow of [] cancels out vim-pandoc-syntax for footnotes [^1]
" ????? TODO
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['<', '>']]
autocmd FileType * if &filetype == 'pandoc' | RainbowParentheses! | endif
"let g:rainbow_active = 0
"au FileType c,cpp,objc,objcpp call RainbowToggleOn

" sudo read/write, w!!
Plug 'lambdalisue/suda.vim'

"Plug 'junegunn/fzf.vim'
"Plug 'fiatjaf/neuron.vim'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-markdownfootnotes'
Plug 'vim-pandoc/vim-criticmarkup'

" Instead of vimwiki/vimwiki use those mappings. I do not use
" any other features of vimwiki, and vimwiki doesn't cooperate
" with vim-pandoc very well. Better to use vim-pandoc only...
nnoremap <leader>ww :edit ~/vimwiki/index.md<cr>
" Open existing or create new file based on filename under cursor,
" add extension of currently opened file if target filename has none.
nnoremap <expr> <leader>gf expand('<cfile>:e') != ''
			\ ? ':edit %:h/<cfile><cr>'
			\ : ':edit %:h/<cfile>.%:e<cr>'

" Toggle, display and navigate marks
Plug 'https://github.com/kshenoy/vim-signature.git'
    " mx    Toggle mark 'x'
    " m,    Place next available mark
    " m.    If no mark on line, place next available mark, otherwise remove (first) existing mark
    " dmx   Remove mark 'x'
    " ]`    Jump to next mark
    " [`    Jump to prev mark
    " m/    Open list of marks in denite
    nnoremap <silent> m/ :Denite -buffer-name=mark mark<cr>

Plug 'inkarkat/vim-mark' |
    Plug 'inkarkat/vim-ingo-library'
    " <Leader>m   mark current world
    " <Leader>n   remove mark of current world
    " <Leader>*   jump to next occurrence of current mark, remember it as last mark
    " <Leader>/   jump to next occurrence of ANY mark
    " <Leader>#   jump to previous occurrence of most recently mark
    " *           ...

" Interesting concept, but buggy and slow.
"Plug 'https://github.com/chrisbra/DynamicSigns.git'

" CamelCase and sneak_case support.
Plug 'chaoren/vim-wordmotion'
    nmap <C-Left> b
    nmap <C-Right> w
    imap <C-Left> <left><esc>bi
    imap <C-Right> <right><esc>wi

" Interesting plugin turning vim into debugger for python, tcl, c, c++, ...
" Plug 'puremourning/vimspector'

call plug#end()

let g:lsp_documentation_float = 1

source ~/.config/nvim/common.vim

source ~/.config/nvim/denite.vim

source ~/.config/nvim/defx.vim

source ~/.config/nvim/asyncomplete.vim

" source ~/.config/nvim/deoplete.vim

" source ~/.config/nvim/coc.vim

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns and make denite look good
set signcolumn=yes
autocmd Filetype denite-filter setlocal signcolumn=yes
autocmd Filetype denite setlocal signcolumn=no

set completeopt-=preview

source ~/.config/nvim/colors.vim

cmap w!! w suda://%

