" Defx

function! My_defx_open() abort
	let w:defx_pwd = expand('%:p:h')
	let defx_tail = expand('%:t')
	call defx#util#call_defx('Defx', w:defx_pwd)
    call defx#call_action('resize', winwidth(0) + 2)
	call search(defx_tail)
endfunction
function! My_defx_resize(context) abort
    call defx#call_action('resize', (winwidth(0) + 2) / 2)
endfunction

nnoremap <silent> - :call My_defx_open()<cr>

call defx#custom#option('_', {
			\ 'columns': 'mark:indent:icon:filename:type:size:time',
			\ 'root_marker': ':',
			\ })
call defx#custom#column('filename', {
			\ 'root_marker_highlight': 'Ignore',
			\ })
call defx#custom#column('time', {
			\ 'format': "%d.%m.%y %H:%M"
			\ })

call defx#custom#column('filename', {
            \ 'min_width': 20,
            \ 'max_width': -37,
            \ })

" 36 is width of 'type:size:time'
"call defx#custom#column('filename', {
"            \ 'min_width': winwidth(0) - 36,
"            \ 'max_width': winwidth(0) - 36,
"            \ })

autocmd FileType defx call s:my_defx_settings()
function! s:my_defx_settings() abort

	" Define mappings
    nnoremap <silent><expr> <C-l>
                \ defx#do_action('resize', winwidth(0) + 2)

	nnoremap <silent><buffer><expr> P
				\ defx#do_action('preview')
	nnoremap <silent><buffer><expr> -
				\ defx#do_action('quit')
	nnoremap <silent><buffer><expr> <CR>
				\ defx#do_action('open')
	nnoremap <silent><buffer><expr> c
				\ defx#do_action('copy')
	nnoremap <silent><buffer><expr> m
				\ defx#do_action('move')
	nnoremap <silent><buffer><expr> p
				\ defx#do_action('paste')
	nnoremap <silent><buffer><expr> v
				\ defx#do_action('multi', [['call', 'My_defx_resize'], ['drop', 'vsplit']])
	nnoremap <silent><buffer><expr> s
				\ defx#do_action('open', 'split')
	nnoremap <silent><buffer><expr> t
				\ defx#do_action('open_or_close_tree')
	nnoremap <silent><buffer><expr> K
				\ defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N
				\ defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> d
				\ defx#do_action('remove')
	nnoremap <silent><buffer><expr> r
				\ defx#do_action('rename')
	nnoremap <silent><buffer><expr> !
				\ defx#do_action('execute_command')
	nnoremap <silent><buffer><expr> x
				\ defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> yy
				\ defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> .
				\ defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> <Backspace>
				\ defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~
				\ defx#do_action('cd')
	nnoremap <silent><buffer><expr> cc
				\ defx#do_action('cd', [w:defx_pwd])
	nnoremap <silent><buffer><expr> q
				\ defx#do_action('quit')
	nnoremap <silent><buffer><expr> <Space>
				\ defx#do_action('toggle_select') . 'j'
	nnoremap <silent><buffer><expr> *
				\ defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr> cd
				\ defx#do_action('change_vim_cwd')

endfunction

" Use Defx instead of netrw as default file explorer

let g:loaded_netrwPlugin = 1            " Disable netrw.vim

augroup my_defx
  autocmd BufEnter,VimEnter,BufNew,BufWinEnter,BufRead,BufCreate
        \ * call s:my_browse_check(expand('<amatch>'))
augroup END

function! s:my_browse_check(path) abort
	let path = a:path
	" For ":edit ~" since the a:path is '/home/user/~'
	if fnamemodify(path, ':t') ==# '~'
		let path = '~'
	endif
	let path = expand(path)
	if isdirectory(path)
		call defx#util#call_defx('Defx', path)
        call defx#call_action('resize', winwidth(0) + 2)
	endif
endfunction

