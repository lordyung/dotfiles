"vim-session
if isdirectory(expand("~/.vim/bundle/vim-session/"))
	" git clone https://github.com/xolox/vim-session
	let g:session_autosave_silent=0
	let g:session_autosave = 0
	let g:session_autoload = 0
	" TODO
endif

if isdirectory(expand("~/.vim/bundle/vim-session/"))
    nmap <leader>sl :ViewSession<CR>
    nmap <leader>ss :SaveSession<CR>
    nmap <leader>sc :CloseSession<CR>
endif
