"vim-tmux-navigator
if isdirectory(expand("~/.vim/bundle/vim-tmux-navigator/"))
	" git clone https://github.com/christoomey/vim-tmux-navigator
	" <ctrl-h> => Left
	" <ctrl-j> => Down
	" <ctrl-k> => Up
	" <ctrl-l> => Right
	" <ctrl-\> => Previous split
	let g:tmux_navigator_no_mappings = 1

	nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
	nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
	nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
	nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
	nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
	" Write all buffers before navigating from Vim to tmux pane
	let g:tmux_navigator_save_on_switch = 2

endif

" TEMP 设置, 尚未确定要不要
" tmux
" function! WrapForTmux(s)
"   if !exists('$TMUX')
"     return a:s
"   endif
"
"   let tmux_start = "\<Esc>Ptmux;"
"   let tmux_end = "\<Esc>\\"
"
"   return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
" endfunction
"
" let &t_SI .= WrapForTmux("\<Esc>[?2004h")
" let &t_EI .= WrapForTmux("\<Esc>[?2004l")

" allows cursor change in tmux mode
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" if exists('$TMUX')
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" endif
"}
"let &amp;t_SI .= WrapForTmux("<Esc>[?2004h")
"let &amp;t_EI .= WrapForTmux("<Esc>[?2004l")

function! XTermPasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
"}
" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)

function! WrapForTmux(s)
	if !exists('$TMUX')
		return a:s
	endif

	let tmux_start = "<Esc>Ptmux;"
	let tmux_end = "<Esc>"

	return tmux_start . substitute(a:s, "<Esc>", "<Esc><Esc>", 'g') . tmux_end
endfunction
