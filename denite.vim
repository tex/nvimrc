" auto_resume to resume insert/normal mode when entering Denite buffer by pressing ALT-Arrows

call denite#custom#option(
			\ '_', {
			\ 'prompt': '>>',
			\ 'winheight': 10,
			\ 'auto_resume' : v:true,
			\ 'filter_split_direction': 'floating',
			\ 'max_dynamic_update_candidates': 100000,
			\ })

call denite#custom#source('_', 'matchers', ['matcher/regexp'])


nnoremap [denite] <Nop>
nmap <space> [denite]

nnoremap <silent> [denite]f :Denite -buffer-name=file_rec file/rec<cr>
nnoremap <silent> [denite]m :Denite -buffer-name=file_mru file_mru<cr>
nnoremap <silent> [denite]b :Denite -buffer-name=buffer buffer<cr>
nnoremap <silent> [denite]g :Denite -buffer-name=grep -start-filter grep:::!<cr>

nnoremap <silent> z=        :Denite -buffer-name=spell spell
            \ -split=floating -winwidth=30 -winheight=`&lines-2` -wincol=`&columns` -winrow=0<cr>
"           \ -split=floating_relative -winwidth=30<cr>
nnoremap <silent> ""        :Denite -buffer-name=meoyank_register neoyank register<cr>

autocmd FileType c,cpp,yacc,java,php,asm,erlang,python nnoremap <silent> g[
			\   :DeniteCursorWord -buffer-name=gtags_ref gtags_ref<cr>
autocmd FileType c,cpp,yacc,java,php,asm,erlang,python nnoremap <silent> g]
			\   :DeniteCursorWord -buffer-name=gtags_def gtags_def<cr>


autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <cr> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> a denite#do_map('choose_action')
	nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> <c-s> denite#do_map('do_action', 'split')
	nnoremap <silent><buffer><expr> <c-v> denite#do_map('do_action', 'vsplit')
	nnoremap <silent><buffer><expr> q denite#do_map('quit')
	nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    inoremap <silent><buffer> <down> <Esc>
                \:call denite#move_to_parent()<CR>
                \:call cursor(line('.')+1,0)<CR>
                \:call denite#move_to_filter()<CR>A
    inoremap <silent><buffer> <up> <Esc>
                \:call denite#move_to_parent()<CR>
                \:call cursor(line('.')-1,0)<CR>
                \:call denite#move_to_filter()<CR>A
    inoremap <silent><buffer> <pagedown> <Esc>
                \:call denite#move_to_parent()<CR>
                \:call cursor(line('.')+9,0)<CR>
                \:call denite#move_to_filter()<CR>A
    inoremap <silent><buffer> <pageup> <Esc>
                \:call denite#move_to_parent()<CR>
                \:call cursor(line('.')-9<1?1:line('.')-9,0)<CR>
                \:call denite#move_to_filter()<CR>A
endfunction


