" ctrlp
if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
	" git clone https://github.com/kien/ctrlp.vim

	" Run :CtrlP or :CtrlP [starting-directory] to invoke CtrlP in find file mode.
	" Run :CtrlPBuffer or :CtrlPMRU to invoke CtrlP in find buffer or find MRU file mode.
	" Run :CtrlPMixed to search in Files, Buffers and MRU files at the same time.

	let g:ctrlp_map = '<c-p>'
	let g:ctrlp_cmd = 'CtrlP'
	let g:ctrlp_working_path_mode = 'ra'

	set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.moc,*.png

	let g:ctrlp_custom_ignore = {
				\ 'dir':  '\v[\/]\.(git|hg|svn|moc|obj|rcc)$',
				\ 'file': '\v\.(exe|so|dll|o|moc)$',
				\ 'link': 'some_bad_symbolic_links',
				\ }

	let g:ctrlp_user_command = 'find %s -type f'
endif
" ctrlp-funky
"------------------------------------------------------------
if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
	" git clone https://github.com/tacahiroy/ctrlp-funky
    nnoremap <Leader>fu :CtrlPFunky<CR>
	nnoremap <Leader>fu :CtrlPFunky<Cr>
	nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
	let g:ctrlp_extensions = ['funky']
	let g:ctrlp_funky_syntax_highlight = 1
endif
