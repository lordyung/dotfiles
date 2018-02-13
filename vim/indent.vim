"indentLine
if isdirectory(expand("~/.vim/bundle/indentLine/"))
    " git clone https://github.com/Yggdroot/indentLine
    " 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
    let g:indentLine_color_term = 239 " 设置终端对齐线颜色
    let g:indentLine_enabled = 1
    " map
    nnoremap <silent> <Leader>z :ZoomToggle<CR>
    nmap <leader>il :IndentLinesToggle<CR>

endif

"vim-indent-guides
if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
    " git clone https://github.com/nathanaelkane/vim-indent-guides
    hi IndentGuidesOdd  ctermbg=black
    hi IndentGuidesEven ctermbg=darkgrey
endif

"vim-surround
if isdirectory(expand("~/.vim/bundle/vim-surround/"))
    " git clone git://github.com/tpope/vim-surround
    " cs"': To change " to '
    " ds" : To remove the delimiters entirely
    " ysiw]: To add ] on a text object
    " yss]: To add ] without space
endif

"supertab
if isdirectory(expand("~/.vim/bundle/supertab/"))
    " git clone https://github.com/ervandew/supertab
    let g:SuperTabDefaultCompletionType = "<c-n>"
    let c_cpp_comments = 1
endif

if isdirectory(expand("~/.vim/bundle/tabular"))
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
    vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
    nmap <Leader>a=> :Tabularize /=><CR>
    vmap <Leader>a=> :Tabularize /=><CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a,, :Tabularize /,\zs<CR>
    vmap <Leader>a,, :Tabularize /,\zs<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif
