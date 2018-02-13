" git-vim
if isdirectory(expand("~/.vim/bundle/git-vim/"))
	" git clone https://github.com/motemen/git-vim
	"<Leader>gd :GitDiff
	"<Leader>gD :GitDiff –cached
	"<Leader>gs :GitStatus
	"<Leader>gl :GitLog
	"<Leader>ga :GitAdd
	"<Leader>gA :GitAdd <cfile>
	"<Leader>gc :GitCommit
	"<Leader>gb :GitBlame 
endif

" Fugitive
if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    " Mnemonic _i_nteractive
    nnoremap <silent> <leader>gi :Git add -p %<CR>
    nnoremap <silent> <leader>gg :SignifyToggle<CR>
endif
