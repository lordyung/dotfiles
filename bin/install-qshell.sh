# a script to run download and run qshell in deferent platform.
#!/bin/bash
# https://code.aliyun.com/dist/files/blob/master/win/qshell.exe

hash qshell 2>/dev/null || {
if [ `uname -s` = "Darwin" ]; then
    wget https://code.aliyun.com/dist/files/raw/master/darwin/qshell_darwin -O  ~/.bin/qshell
    chmod +x ~/.bin/qshell
elif [ `uname -s` = "Linux" ]; then
    wget https://code.aliyun.com/dist/files/raw/master/linux/qshell_linux -O  ~/.bin/qshell
    chmod +x ~/.bin/qshell
else
    echo "Don't Support this system."
fi
}
