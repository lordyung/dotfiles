"vim-system-copy
if isdirectory(expand("~/.vim/bundle/vim-system-copy/"))
    " git clone https://github.com/christoomey/vim-system-copy
    " Usuage: xsel can be installed with pacman -S xsel if your system doesn't have it installed
    " The default mapping is cp, and can be followed by any motion or text object.
    " For instance:
    " `cpiw `=> copy word into system clipboard
    " `cpi` => copy inside single quotes to system clipboard
    " In addition, cP is mapped to copy the current line directly.
    " The sequence cv is mapped to paste the content of system clipboard to the next line.
    let g:system_copy#copy_command='xclip -sel clipboard'
    let g:system_copy#paste_command='xclip -sel clipboard -o'
endif
