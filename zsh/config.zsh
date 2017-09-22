# export
export ARCHFLAGS="-arch x86_64"
export CLICOLOR='Yes' #是否输出颜色
export EDITOR='vim';
export HISTCONTROL='ignoreboth';
export HISTFILESIZE="${HISTSIZE}";
export HISTSIZE='32768';
export LESS_TERMCAP_md="${yellow}";
export MANPAGER='less -X';
export NODE_REPL_HISTORY=~/.node_history;
export NODE_REPL_HISTORY_SIZE='32768';
export NODE_REPL_MODE='sloppy';
export PYTHONIOENCODING='UTF-8';

export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en

# change homebrew bottle mirror
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

export HOMEBREW_NO_AUTO_UPDATE=true

export PATH=~/.bin:/opt/local/sbin:/opt/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

export MANPATH=/opt/local/share/man:$MANPATH
# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export GOPATH=$HOME/.go

export FORCE_UNSAFE_CONFIGURE=1

# manpages colors
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode
export LESS_TERMCAP_md=$(printf '\e[01;38;5;75m') # enter double-bright mode
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;38;5;200m') # enter underline mode

# jdk1.8.0_102
if [ -d /usr/local/jdk1.8.0_102 ]; then
    export JAVA_HOME=/usr/local/jdk1.8.0_102
    export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
    export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
fi

# alias
alias ag='ag -f --hidden'
alias cls='clear'
alias cp='cp -v'
alias fs="stat -f \"%z bytes\""
alias h="history"
alias j="jobs"
alias path='echo -e ${PATH//:/\\n}' # Print each PATH entry on a separate line
alias pc="ALL_PROXY=socks5://127.0.0.1:1088 proxychains4" # 为Macos设置终端代理
alias plistbuddy="/usr/libexec/PlistBuddy" # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias rg="ranger"
alias spotoff="sudo mdutil -a -i off" # Disable Spotlight
alias ungz="gunzip -k"
alias vi='vim'
alias ln='ln -sf'
alias week='date +%V' # Get week number
# alias wget="curl -O"

# brew
alias brwe=brew  #typos
#alias brew_update="brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor; npm-check -g -u"
alias update_brew_npm_gem='brew_update; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update --no-document'
alias cask='brew cask' # i <3 u cask

alias ai='sudo apt-get install -y'
alias af='apt-cache search '

# yum
alias ys='yum search '
alias yi='sudo yum install '
alias yr='sudo yum remove '
alias yl='yum list '


# rpm

alias rl='rpm -ql'
alias ro='rpm -qo'

#feeds

alias feedi="./scripts/feeds install"
alias feedg="./scripts/feeds list | grep"


alias d="dist"
# ls
# http://linux-sxs.org/housekeeping/lscolors.html
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
alias ls='ls --color=auto'
alias lsd='ls -l | grep "^d"'


# disk
alias diskspace_report="df -P -kHl"
alias free_diskspace_report="diskspace_report"

# git
alias g="git"
alias gac='git add -A && git commit -m'
alias gb='git branch'
alias gc='git commit -m'
alias gca='git commit -a'
alias gcb='git copy-branch-name'
alias gco='git checkout'
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'
alias grep='grep --color=auto'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.


# grep
alias egrep='egrep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias fgrep='fgrep --color=auto'
alias fn='find -iname'
alias ft='find -type'

# network
alias hosts='sudo $EDITOR /etc/hosts'   # yes I occasionally 127.0.0.1 twitter.com ;)
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

if [ -f /etc/redhat-release ]; then
    alias qmake='qmake-qt5'
fi

if [ $(uname) = "Darwin" ]; then
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
    alias c="tr -d '\n' | pbcopy"
    alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
    alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder" # Flush Directory Service cache
    alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
    alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
    alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
    alias md5sum="md5"
    alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'
    alias sha1sum="shasum"
    alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
    alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
    alias badge="tput bel" # Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
    alias c='pygmentize -O style=monokai -f console256 -g' # `cat` with beautiful colors. requires: sudo easy_install -U Pygments
    alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder" # Flush Directory Service cache
    alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"


    alias bi="brew install"
    alias bf="brew info"
    alias bs="brew search"

    alias ci="brew cask install"
    alias cf="brew cask info"
    alias cs="brew cask search"
    alias subl='open -a Sublime'
fi


# qshell
alias fput='qshell fput'




