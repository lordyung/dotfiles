if isdirectory(expand("~/.vim/bundle/tagbar/"))
"    let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
    let g:tagbar_width=40
    let g:tagbar_left=0
    let g:tagbar_right=1
    let Tlist_Auto_Open = 0
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
endif
