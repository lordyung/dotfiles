"Syntastic
if isdirectory(expand("~/.vim/bundle/syntastic/"))
    " git clone https://github.com/vim-syntastic/syntastic
    " 用于保存文件是查检语法
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    " syntastic_include_dirs
    let g:syntastic_c_include_dirs = ['/usr/include/GLFW']
endif
