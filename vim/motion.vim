"matchit.zip
if isdirectory(expand("~/.vim/bundle/matchit.zip/"))
    " 对%命令进行扩展使得能在嵌套标签和语句之间跳转
    " % 正向匹配 g% 反向匹配
    " [% 定位块首 ]% 定位块尾Leader>mm - 在当前行打一个标记，使用下一个可用的标记名
endif
