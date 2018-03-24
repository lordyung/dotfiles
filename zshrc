# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/oh-my-zsh

# theme
# ZSH_THEME="random"
# ZSH_THEME="muze"
# ZSH_THEME="gnzh"
ZSH_THEME="duellj"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
DISABLE_UNTRACKED_FILES_DIRTY="false"

# stamp shown in the history command output.

HIST_STAMPS="mm/dd/yyyy" # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump)


setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
# User configuration
source $ZSH/oh-my-zsh.sh

# alias and export
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

export PATH=~/.dotfiles/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

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

# jdk1.8.0_152
if [ -d /opt/jdk1.8.0_152 ]; then
    export JAVA_HOME=/opt/jdk1.8.0_152
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
# alias pc="ALL_PROXY=socks5://127.0.0.1:1080 proxychains4" # 为Macos设置终端代理
alias rg="ranger"
alias ungz="gunzip -k"
alias vi='vim'
alias ln='ln -sf'
alias week='date +%V' # Get week number
# alias wget="curl -O"

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

# qshell
alias fput='qshell fput'




# function
function mkd() {
mkdir -p "$@" && cd "$_";
}


# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
local tmpFile="${@%/}.tar";
tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

size=$(
stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
);

local cmd="";
if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    cmd="zopfli";
else
    if hash pigz 2> /dev/null; then
        cmd="pigz";
    else
        cmd="gzip";
    fi;
fi;

echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
"${cmd}" -v "${tmpFile}" || return 1;
[ -f "${tmpFile}" ] && rm "${tmpFile}";

zippedSize=$(
stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
);

echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

# Determine size of a file or total size of a directory
function fs() {
if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
else
    local arg=-sh;
fi
if [[ -n "$@" ]]; then
    du $arg -- "$@";
else
    du $arg .[^.]* ./*;
fi;
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
    function gdiff() {
    git diff --no-index --color-words "$@";
}
fi;

# Create a data URL from a file
function dataurl() {
local mimeType=$(file -b --mime-type "$1");
if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8";
fi
echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Create a git.io short URL
function gitio() {
if [ -z "${1}" -o -z "${2}" ]; then
    echo "Usage: \`gitio slug url\`";
    return 1;
fi;
curl -i https://git.io/ -F "url=${2}" -F "code=${1}";
}

# prompt_git
prompt_git() {
    local s='';
    local branchName='';

    # Check if the current directory is in a Git repository.
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

            # Ensure the index is up to date.
            git update-index --really-refresh -q &>/dev/null;

            # Check for uncommitted changes in the index.
            if ! $(git diff --quiet --ignore-submodules --cached); then
                s+='+';
            fi;

            # Check for unstaged changes.
            if ! $(git diff-files --quiet --ignore-submodules --); then
                s+='!';
            fi;

            # Check for untracked files.
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                s+='?';
            fi;

            # Check for stashed files.
            if $(git rev-parse --verify refs/stash &>/dev/null); then
                s+='$';
            fi;

        fi;

        # Get the short symbolic ref.
        # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
        # Otherwise, just give up.
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
            git rev-parse --short HEAD 2> /dev/null || \
            echo '(unknown)')";

        [ -n "${s}" ] && s=" [${s}]";

        echo -e "${1}${branchName}${2}${s}";
    else
        return;
    fi;
}
# Start an HTTP server from a directory, optionally specifying the port
function server() {
local port="${1:-8000}";
sleep 1 && open "http://localhost:${port}/" &
# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
local port="${1:-4000}";
local ip=$(ipconfig getifaddr en1);
sleep 1 && open "http://${ip}:${port}/" &
php -S "${ip}:${port}";
}

# Compare original and gzipped file size
function gz() {
local origsize=$(wc -c < "$1");
local gzipsize=$(gzip -c "$1" | wc -c);
local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
printf "orig: %d bytes\n" "$origsize";
printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript;
else # pipe
    python -mjson.tool | pygmentize -l javascript;
fi;
}

# Run `dig` and display the most useful info
function digga() {
dig +nocmd "$1" any +multiline +noall +answer;
}

# UTF-8-encode a string of Unicode symbols
function escape() {
printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
# print a newline unless we’re piping the output to another program
if [ -t 1 ]; then
    echo ""; # newline
fi;
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
# print a newline unless we’re piping the output to another program
if [ -t 1 ]; then
    echo ""; # newline
fi;
}

# Get a character’s Unicode code point
function codepoint() {
perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
# print a newline unless we’re piping the output to another program
if [ -t 1 ]; then
    echo ""; # newline
fi;
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
if [ -z "${1}" ]; then
    echo "ERROR: No domain specified.";
    return 1;
fi;

local domain="${1}";
echo "Testing ${domain}…";
echo ""; # newline

local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" \
        | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
        no_serial, no_sigdump, no_signame, no_validity, no_version");
    echo "Common Name:";
    echo ""; # newline
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
    echo ""; # newline
    echo "Subject Alternative Name(s):";
    echo ""; # newline
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
        | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
    return 0;
else
    echo "ERROR: Certificate not found.";
    return 1;
fi;
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s() {
if [ $# -eq 0 ]; then
    subl .;
else
    ([ ! -f $@ ];touch $@); subl "$@";
fi;
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v() {
if [ $# -eq 0 ]; then
    vim .;
else
    vim "$@";
fi;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
if [ $# -eq 0 ]; then
    open .;
else
    open "$@";
fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Generate script in bash and save it to location requiring sudo
# http://stackoverflow.com/questions/4412029/generate-script-in-bash-and-save-it-to-location-requiring-sudo
# http://stackoverflow.com/questions/84882/sudo-echo-something-etc-privilegedfile-doesnt-work-is-there-an-alterna
sudoe() {
    if ([[ "$1" == "-a"  ]] || [[ "$1" == "--no-append"  ]]); then
        shift &>/dev/null || local failed=1
    else
        local append="--append"
    fi

    while [[ $failed -ne 1  ]]; do
        if [[ -t 0  ]]; then
            text="$1"; shift &>/dev/null || break
        else
            text="$(cat <&0)"
        fi

        [[ -z "$1"  ]] && break
        echo "$text" | sudo tee $append "$1" >/dev/null; return $?
    done

    echo "Usage: $0 [-a|--no-append] [text] <file>"; return 1

}

# Nukes a branch locally and on the origin remote.
function git-nuke
{
    git branch -D $1
    git push origin :$1
}

# Promotes a local topic branch to a remote tracking branch of the same name,
# by pushing and then setting up the git config
#
# Thanks to ENTP:
# http://hoth.entp.com/2008/11/10/improving-my-git-workflow
function git_promote
{
    curr_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')

    remote_branch=$(git branch -r | grep "origin/${curr_branch}")
    [ -z "${remote_branch}" ] && ( git push origin "${curr_branch}" )

    origin=$(git config --get "branch.${curr_branch}.remote")
    [ -z "${origin}" ] && ( git config --add "branch.${curr_branch}.remote" origin )

    merge=$(git config --get "branch.${curr_branch}.merge")
    [ -z "${merge}" ] && ( git config --add "branch.${curr_branch}.merge" "refs/heads/${curr_branch}" )
}

# Sets up your branch to track a remote branch. Assumes you mean
# `origin/$branch-name`.
function git_track
{
    branch=$(git rev-parse --abbrev-ref HEAD)
    git branch $branch --set-upstream-to origin/$branch
}

# Undo your last commit, but don't throw away your changes
function git_undo
{
    git reset --soft HEAD^
}

# Show the diff of everything you haven't pushed yet.
function git_unpushed
{
    branch=$(git rev-parse --abbrev-ref HEAD)
    git diff origin/$branch..HEAD
}

# Show the diffstat of everything you haven't pushed yet.
function git_unpushed_stat
{
    branch=$(git rev-parse --abbrev-ref HEAD)
    count=$(git rev-list --count HEAD origin/$branch...HEAD)

    if [ "$count" -eq "1" ]
    then
        s=''
    else
        s='s'
    fi

    git diff --stat origin/$branch..HEAD
    echo " $count commit$s total"
}

# auto run when user login
# http://tmux-users.narkive.com/0ujAyFAh/sessions-should-be-nested-with-care-unset-tmux-to-force
# if [[ "$TERM" != "screen-256color"   ]] && which tmux 2 &> /dev/null; then
#     exec tmux -S /tmp/tmux-$USER new-session -A -s "tmux-$USER"
# fi

if [ $(uname) = "Darwin" ]; then
    # change homebrew bottle mirror
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
    export HOMEBREW_NO_AUTO_UPDATE=true
    # findutils
    alias find=gfind
    alias locate=glocate
    alias updatedb=gupdatedb
    alias xargs=gxargs
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

    alias ls='gls --color=auto'

    alias ss=proxychains4
    alias plistbuddy="/usr/libexec/PlistBuddy" # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
    alias ctags="/usr/local/bin/ctags"

    # brew
    alias brwe=brew  #typos

    alias ci="brew cask install"
    alias cf="brew cask info"
    alias cs="brew cask search"
    alias subl='open -a Sublime'
    alias spotoff="sudo mdutil -a -i off" # Disable Spotlight

    #alias brew_update="brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor; npm-check -g -u"
    alias update_brew_npm_gem='brew_update; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update --no-document'
    alias cask='brew cask' # i <3 u cask

    # Change working directory to the top-most Finder window location
    function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}
fi

if [ -f $HOME/.custom.zsh ]; then
    source $HOME/.custom.zsh
fi
