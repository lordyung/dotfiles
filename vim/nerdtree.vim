" nerdtree
if isdirectory(expand("~/.vim/bundle/nerdtree"))
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
    let g:NERDTreeWinSize=25

	" Open a NERDTree automatically when vim starts up
	" autocmd vimenter * NERDTree

	" Open a NERDTree automatically when vim starts up if no files were specified
	" autocmd StdinReadPre * let s:std_in=1
	" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

	" Close vim if the only window left open is a NERDTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let g:NERDTreeDirArrowExpandable = '▸'
	let g:NERDTreeDirArrowCollapsible = '▾'

    " autocmd vimenter * NERDTree

	" How can I open NERDTree automatically when vim starts up on opening a directory?
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0]
endif
" nerdtree-git-plugin
if isdirectory(expand("~/.vim/bundle/nerdtree-git-plugin"))
	" git clone https://github.com/Xuyuanp/nerdtree-git-plugin
	let g:NERDTreeIndicatorMapCustom = {
				\ "Modified"  : "✹",
				\ "Staged"    : "✚",
				\ "Untracked" : "✭",
				\ "Renamed"   : "➜",
				\ "Unmerged"  : "═",
				\ "Deleted"   : "✖",
				\ "Dirty"     : "✗",
				\ "Clean"     : "✔︎",
				\ "Unknown"   : "?"
				\ }
endif
" vim-nerdtree-tabs
if isdirectory(expand("~/.vim/bundle/vim-nerdtree-tabs"))
	" git clone https://github.com/Xuyuanp/nerdtree-git-plugin
	" :NERDTreeTabsOpen switches NERDTree on for all tabs.
	" :NERDTreeTabsClose switches NERDTree off for all tabs.
	" :NERDTreeTabsToggle toggles NERDTree on/off for all tabs.
	" :NERDTreeTabsFind find currently opened file and select it
endif
