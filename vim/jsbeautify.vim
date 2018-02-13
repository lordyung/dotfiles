"jsbeautify
if exists('jsbeautify')
    autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<CR>
    autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<CR>
    autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<CR>
    autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<CR>
    autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<CR>
    autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<CR>
    autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<CR>
    autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<CR>
    autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<CR>
    autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<CR>
endif
