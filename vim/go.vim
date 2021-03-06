" vim-go
if isdirectory(expand("~/.vim/bundle/vim-go/"))
	" https://github.com/fatih/vim-go
	let g:go_highlight_functions = 1
	let g:go_highlight_methods = 1
	let g:go_highlight_structs = 1
	let g:go_highlight_operators = 1
	let g:go_highlight_build_constraints = 1
	let g:go_fmt_command = "goimports"
	let g:go_fmt_autosave = 0
	let g:go_play_open_browser = 0
	let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
	let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
endif
