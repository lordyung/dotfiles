if isdirectory(expand("~/.vim/bundle/tagbar/"))
    let g:tagbar_ctags_bin = '/usr/bin/ctags'
    let g:tagbar_width=20
    let g:tagbar_left=1

    nnoremap <silent> <leader>tt :TagbarToggle<CR>
endif
