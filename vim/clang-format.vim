"clang-format
if isdirectory(expand("~/.vim/bundle/vim-clang-format/"))
let g:clang_format#code_style = 'llvm'  "llvm, google, chromium, mozilla is supported. 
" let g:clang_format#auto_format
" let g:clang_format#auto_format_on_insert_leave
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \"AlwaysBreakTemplateDeclarations" : "true",
            \"Standard" : "C++11",
            \"BreakBeforeBraces" : "Stroustrup" }

" Toggles between the active and last active tab "
" The first tab is always 1 "

let g:last_active_tab = 1
if exists('clangformat')
    autocmd FileType c ClangFormatAutoEnable
    autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
    "nmap <Leader>C :ClangFormatAutoToggle<CR>
    "autocmd FileType c ClangFormatAutoEnable
endif
endif
"}
