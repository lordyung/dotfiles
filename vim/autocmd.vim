"autocmd BufRead,BufNewFile,BufEnter * cd %:p:h " 自动切换目录为当前编辑文件所在目录
"autocmd BufRead,BufNewFile,BufEnter *.{c,cpp,h,javascript} call CSyntaxAfter()
"autocmd Filetype c setlocal foldmethod=indent
"autocmd Filetype vim noremap <F1> <Esc>:help <C-r><C-w><CR>
"autocmd! BufNewFile,BufRead * setlocal nofoldenable list
"autocmd FocusLost * :set norelativenumber number

"autocmd FocusGained * :set relativenumber

"autocmd InsertEnter * :set mouse= paste
"autocmd InsertLeave * :set mouse=a nopaste
autocmd BufNewFile,BufRead *.install setlocal syntax=sh ft=sh
autocmd TabLeave * let g:last_active_tab = tabpagenr()
autocmd BufNewFile,BufRead *.less set filetype=css
autocmd BufNewFile,BufRead *.mk setlocal filetype=make
autocmd BufNewFile,BufRead *.phtml set filetype=php
autocmd BufNewFile,BufRead PKGBUILD setlocal syntax=sh ft=sh
autocmd BufRead,BufNewFile *.js set ft=javascript.jquery
autocmd BufRead,BufNewFile *.json setlocal ft=javascript
"autocmd BufRead,BufNewFile *.tpl setlocal ft=tpl syntax=html
autocmd BufRead,BufNewFile *.txt setlocal ft=txt
autocmd BufRead,BufNewFile *.conf setlocal ft=sh
autocmd BufRead,BufNewFile jquery.*.js setlocal ft=javascript syntax=jquery
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
"autocmd BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
"autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown
autocmd BufRead,BufNewFile CMakeLists.txt set filetype=cmake
autocmd BufRead,BufNewFile *.part set filetype=html
" disable showmatch when use > in php

" for # indent, python文件中输入新行时#号注释不切回行首
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#
autocmd BufWinEnter *.php set mps-=<:>
autocmd FileType css setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType css setlocal smartindent foldmethod=indent
autocmd FileType html,xhtml setlocal smartindent foldmethod=indent
autocmd FileType markdown setlocal shiftwidth=4 expandtab
"autocmd FileType php set shiftwidth=4 tabstop=4 expandtab softtabstop=4
"autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType text setlocal textwidth=78
autocmd Filetype vim setlocal foldmethod=marker
autocmd InsertLeave * if pumvisible() == 0|pclose|endif " 离开插入模式后自动关闭预览窗口
autocmd! bufwritepost .vimrc source % " vimrc文件修改之后自动加载
"autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif " Always switch to the current file directory
" Enable omni completion.
" --------------------------------------------------------------------------
if exists('ddddcomplete') 
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS 
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags 
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS 
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete 
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete 
    autocmd FileType haskell setlocal
    autocmd FileType css,less setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php,phtml setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
endif

"go {
"---------------------------------------------------------------------------
if exists('g:lordyung_go')
    au FileType go nmap <Leader>s <Plug>(go-implements)
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <Leader>e <Plug>(go-rename)
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <Leader>gd <Plug>(go-doc)
    au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    au FileType go nmap <leader>co <Plug>(go-coverage)
endif
"}

" Highlight TODO, FIXME, NOTE, etc {
autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
" }
" ctrlp.vim {
"---------------------------------------------------------------------------
if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
endif
" }
" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
if exists('autoclosetag')
    autocmd FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
endif
" }
" Python
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai

" Ruby
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
" Markdown
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

" when save python file, then delete redundant space {
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
" automate insert the header of file
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif
    normal G
    normal o
    normal o
endfunc
