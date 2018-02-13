"设置标记
"ShowMarks
if isdirectory(expand("~/.vim/bundle/ShowMarks/"))
    let g:showmarks_enable = 1
    let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let g:showmarks_ignore_type = "hqm"
    " m{mark} 设置标记 '{mark} 移动到标记
    "<Leader>mt - 打开/关闭ShowMarks插件
    "<Leader>mh - 清除当前行的标记
    "<Leader>ma - 清除当前缓冲区中所有的标记

    " 设置标记一列的背景颜色和数字一行颜色一致
    hi! link SignColumn   LineNr
    hi! link ShowMarksHLl DiffAdd
    hi! link ShowMarksHLu DiffChange
endif
