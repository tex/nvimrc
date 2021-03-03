" Colorscheme

colorscheme darkblue

" I like the darkblue colorscheme but don't like its LineNr being green.
" Prefer non-obtrusive darkgrey.
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

highlight SpellBad ctermfg=202 ctermbg=NONE cterm=NONE
highlight SpellCap ctermfg=202 ctermbg=NONE cterm=NONE
highlight SpellRare ctermfg=202 ctermbg=NONE cterm=NONE
highlight SpellLocal ctermfg=202 ctermbg=NONE cterm=NONE

" Default is some unreadable light-blue:
"term=standout ctermfg=15 ctermbg=81 guifg=#ffffff guibg=#287ef
highlight ErrorMsg term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red

" Default is some unreadable ping with light text:
highlight DiffChange ctermfg=9 ctermbg=NONE cterm=NONE
highlight DiffText   ctermfg=9 ctermbg=NONE cterm=NONE

" I don't know what plugin sets the SignColumn to ctermbg=242
" which I hate since it also messes up the vim-gitgutter.
highlight clear SignColumn

" Default is unreadable
highlight Visual ctermfg=81 ctermbg=21
highlight MatchParn ctermfg=2 ctermbg=NONE cterm=NONE
highlight CursorLine cterm=bold ctermfg=black ctermbg=lightblue

" ================================
" Different color status for each mode.
" ================================
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermbg=lightblue ctermfg=black
  elseif a:mode == 'r'
    hi statusline ctermbg=red ctermfg=black
  else
    hi statusline ctermbg=green ctermfg=black
  endif
endfunction

function! InsertLeaveActions()
  hi statusline ctermbg=green ctermfg=black
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertLeaveActions()
call InsertLeaveActions()

" To handle exiting insert mode via a control-C.
inoremap <c-c> <c-o>:call InsertLeaveActions()<cr><c-c>


highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

