au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

" Example of custom completor

function! s:js_completor(opt, ctx) abort
    let l:col = a:ctx['col']
    let l:typed = a:ctx['typed']

    let l:kw = matchstr(l:typed, '\v\S+$')
    let l:kwlen = len(l:kw)

    let l:startcol = l:col - l:kwlen

    let l:matches = [
        \ "do", "if", "in", "for", "let", "new", "try", "var", "case", "else", "enum", "eval", "null", "this", "true",
        \ "void", "with", "await", "break", "catch", "class", "const", "false", "super", "throw", "while", "yield",
        \ "delete", "export", "import", "public", "return", "static", "switch", "typeof", "default", "extends",
        \ "finally", "package", "private", "continue", "debugger", "function", "arguments", "interface", "protected",
        \ "implements", "instanceof"
        \ ]

    call asyncomplete#complete(a:opt['name'], a:ctx, l:startcol, l:matches)
endfunction

au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'javascript',
    \ 'whitelist': ['javascript'],
    \ 'completor': function('s:js_completor'),
    \ })

" End of example of custom completor

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rls']},
        \ 'workspace_config': {'rls': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
    "au User lsp_setup call lsp#register_server({
    "    \ 'name': 'rust-analyzer',
    "    \ 'cmd': {server_info->['rust-analyzer']},
    "    \ 'whitelist': ['rust'],
    "    \ })
endif

imap <c-space> <Plug>(asyncomplete_force_refresh)

" for vim-lsp
let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('~/vim-lsp.log')
" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

let g:lsp_diagnostics_enabled = 1
let g:asyncomplete_auto_popup = 0

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

nnoremap <silent> K     :LspHover<CR>
nnoremap <silent> <c-k> :LspSignatureHelp<CR>
