#!/bin/bash
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

# Use Git’s colored diff when available
function gdiff() {
    git diff --no-index --color-words "$@";
}
function mkd() {
    mkdir -p "$@" && cd "$_";
}
# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames(){
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

    echo "Usage: $0 [-a|--no-append] [text] <file>"; return -1

}

# Nukes a branch locally and on the origin remote.
function gnuke
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

function tag() {
    rm -f cscope.files  cscope.in.out  cscope.out  cscope.po.out tags
    find  -iname "*.h" -o \
        -iname "*.c" -o \
        -iname "*.cpp" -o \
        -path .git -prune -o \
        -path .rcc -prune -o \
        -path .moc -prune > cscope.files
    ctags --c-kinds=+p --c++-kinds=+p -L cscope.files
    cat cscope.files | wc -l
    cscope -bqu
}

function dist() {
    grep --color=always $1 ~/.dotfiles/lib/distfiles.txt | sed 's|^|http://mirrors.ustc.edu.cn/gentoo/distfiles/|g'
}

function commit-msg() {
    if [ -d .git ];then
        scp code.lordyung.com:hooks/commit-msg .git/hooks/
    else
        echo 'Not in git root directory!'
    fi
}

function gerrit() {
    ssh $USER@code.lordyung.com gerrit $1 $2 $3 $4 $5 $6
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

function rootness() {
    # Make sure only root can run our script
    if [ $EUID -ne 0 ]; then
        echo "You need to be root to perform this command." && return 1
    fi
}
function qpb-all() {
    qshell listbucket book /tmp/.book_list

    for file in `ls`
    do
        grep $file /tmp/.book_list > /dev/null || qp book ${file}
    done
}
function tr-space() {
    find . -name "* *" |
    while read name; do
        na=$(echo $name | tr ' ' '_')
        mv "$name" $na
    done
}
function stop_ss_local() {
    launchctl unload "$HOME/Library/LaunchAgents/com.lordyung.shadowsocks.plist"
}
function gaddremove() {
    FILES=${@:-:/}

    git add -A $FILES
    git ls-files --deleted -z $FILES | xargs -0 git rm
}
function getrealip() {

    curl -s http://checkrealip.com/ |awk '{print $4}'
}
function glast(){
    REVISIONS=${1:-1}
    git log -n ${REVISIONS}
}
function gwip() {
    git addremove
    git commit -m "wip"
}
function gunwip() {
    git reset --soft HEAD^
}
function gindex() {
    git-diff --cached $*
}
function encode() {
    # encode filename in directory
    kfile=~/.ssh/id_rsa

    if  [ ! -f .safe ]; then
        for file in *
        do
            mv -i  $file $(echo $file | openssl base64 -kfile $kfile -base64)
        done
        touch .safe
    fi
}
function qsd() {
    if [ $#  -eq 1  ]; then
        Bucket=distfiles
        Key=$1
    else
        echo Usuage: qsd [key]
        return -1
    fi

    qshell delete distfiles $1
    if [ $? -eq 0 ];then
        echo \'$1\' delete success.
    fi
}
function qp-all() {
    qshell listbucket distfiles /tmp/.distfiles

    for file in `ls *.tar.gz *.tar.xz *.tar.bz2 *.zip`
    do
        grep $file /tmp/.distfiles > /dev/null || qp ${file}
    done
}
function fzf() {
    PLATFORM=`uname`
    case $PLATFORM in
        Linux)
            FZF=fzf-linux;;
        Darwin)
            FZF=fzf-darwin;;
        *)
            FZF=fzf;;
    esac

    $FZF $1 $2 $3 $4
}
function ebuild() {
    if [ ! -d ~/.ebuild ]; then
        git clone git@code.aliyun.com:lordyung/ebuild.git ~/.ebuild
        find ~/.ebuild -iname $1 |grep --color=always $1
    fi
}
function headers(){
    # https://github.com/rtomayko/dotfiles/blob/rtomayko/bin/headers

    curl -sv "$@" 2>&1 >/dev/null |
    grep -v "^\*" |
    grep -v "^}" |
    cut -c3-
}
function decode() {
    # decode filename in directory
    kfile=~/.ssh/id_rsa

    if  [ -f .safe ]; then
        for file in *
        do
            mv  $file $(echo $file | base64 -d)
            # mv  $file $(echo $file | openssl base64 -kfile $kfile -base64 -d)
        done
        rm -f .safe
    fi
}
function qshell() {
    # a script to run download and run qshell in deferent platform.
    #!/bin/bash

    if [ `uname -s` = "Darwin" -a `uname -m` = "x86_64" ]; then
        qshell-darwin-x64 $@
    elif [ `uname -s` = "Linux" -a `uname -m` = "x86_64" ]; then
        qshell-linux-x64 $@
    elif [ `uname -s` = "Linux" -a `uname -m` = "i686" ]; then
        qshell-linux-x86 $@
    else
        echo "Don't Support this system."
    fi

}
function ack(){
    # Quick search in a directory for a string ($@).
    set -e
    hash ack 2>/dev/null || {
    if [ $(check_distro) = 'Ubuntu' ]; then
        sudo apt-get install -y ack-grep || return $?;
    elif [ $(check_distro) = 'RedHat' ]; then
        sudo yum install -y ack || return $?;
    elif [ $(check_distro) = 'Darwin' ]; then
        brew install ack || return $?;
    else
        echo "Don't Support this system." && return -1
    fi
}

    # use -iru to search directories ack usually ignores (like .git)
    if [ -x /usr/bin/ack-grep ]; then
        ack-grep "$@"
    else
        /usr/local/bin/ack  "$@"
    fi
}
function qs(){
    Bucket=distfiles
    Domain=http://ot2jmekaj.bkt.clouddn.com

    if [ ! -f /tmp/list ]; then
        qshell listbucket $Bucket /tmp/list
    fi

    if [ $#  -eq 0 ]; then
        for file in `cat /tmp/list |awk '{print $1}'`
        do
            echo $file
        done
    elif [ $#  -eq 1 ]; then
        for file in `cat /tmp/list |awk '{print $1}' |grep $1`
        do
            echo $file: $Domain/$file
        done
    else
        echo Usuage: qs \(key\) \(prefix\)
        return
    fi
}
function qp(){
    # qshell fput <Bucket> <Key> <LocalFile>
    Bucket=distfiles
    if [ $#  = 1  ]; then
        LocalFile=$1
        Key=$1
    elif [ $#  = 2  ]; then
        LocalFile=$1
        Prefix=$2
        Key=$Prefix/$1
    else
        echo Usuage: qp [Key] \(Prefix\)
        return
    fi

    url=http://ot2jmekaj.bkt.clouddn.com/$Key

    # 测试是否存在此文件
    wget -T 15 --tries=1 --spider $url > /dev/null 2>&1
    [ $? -eq 0 ] && echo $url && hash pbcopy > /dev/null 2>&1  && echo -n $url | pbcopy && return # 将内容复制到Mac剪贴板

    # 将文件推送到Bucket
    qshell fput $Bucket $Key $LocalFile
    [ $? -eq 0 ] && echo $url && hash pbcopy > /dev/null 2>&1  && echo -n $url | pbcopy # 将内容复制到Mac剪贴板
}
function gpatch(){

    CURRENT_BRANCH=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)
    CURRENT_DIR=$(basename $(pwd))

    PATCH_DIR="${HOME}/Documents/Patches/${CURRENT_DIR}"

    mkdir -p ${PATCH_DIR}

    git format-patch master --stdout > ${PATCH_DIR}/${CURRENT_BRANCH}.diff

}
function start_ss_local(){
    #  start_ss_local.sh

    if [ ! -f $HOME/Library/LaunchAgents/com.lordyung.shadowsocks.plist ]; then
        echo cp $HOME/.dotfiles/com.lordyung.shadowsocks.plist $HOME/Library/LaunchAgents/
        cp $HOME/.dotfiles/com.lordyung.shadowsocks.plist $HOME/Library/LaunchAgents/
    fi

    launchctl load "$HOME/Library/LaunchAgents/com.lordyung.shadowsocks.plist"

}
function check_distro(){
    # 检测操作系统和发行版
    PLATFORM=`uname`
    case $PLATFORM in
        Darwin)
            OS=Darwin ;;
        HP-UX)
            OS=HP-UX ;;
        AIX)
            OS=AIX ;;
        SunOS)
            OS=SunOS ;;
        Linux)
            if [ -s /etc/oracle-release ]; then
                OS=Oracle
            elif [ -s /etc/SuSE-release ]; then
                OS=SuSE
            elif [ -f /etc/centos-release ]; then
                OS=CentOS
            elif [ -s /etc/redhat-release ]; then
                OS=RedHat
            elif [ -r /etc/os-release ]; then
                grep 'NAME="Ubuntu"' /etc/os-release > /dev/null 2>&1
                if [ $? -eq 0 ]; then
                    OS=Ubuntu
                fi
            else
                OS="Unknown Linux"
            fi ;;
        *)
            OS="Unknown UNIX/Linux" ;;
    esac
    echo $OS

}
function gincoming(){
    CURRENT_BRANCH=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)

    if [ "${CURRENT_BRANCH}" != "" ]; then

        TARGET="${1}"

        if [ "${TARGET}" == "" ]; then
            TRACKING_REPOSITORY="$(git config branch.${CURRENT_BRANCH}.remote)"

            # there is a tracking repository
            if [ "${TRACKING_REPOSITORY}" != "" ]; then
                REMOTE_REPOSITORY="${TRACKING_REPOSITORY}"
                REMOTE_BRANCH="$(git config branch.${CURRENT_BRANCH}.merge | sed -e 's#^[^/]*/[^/]*/##')"
                TARGET="${REMOTE_REPOSITORY}/${REMOTE_BRANCH}"
            fi
        fi

        echo "From: ${TARGET}"
        echo ""

        git log ..${TARGET}
    fi

}
function goutgoing(){
    CURRENT_BRANCH=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)

    if [ "${CURRENT_BRANCH}" != "" ]; then

        TARGET="${1}"

        if [ "${TARGET}" == "" ]; then
            TRACKING_REPOSITORY="$(git config branch.${CURRENT_BRANCH}.remote)"

            # there is a tracking repository
            if [ "${TRACKING_REPOSITORY}" != "" ]; then
                REMOTE_REPOSITORY="${TRACKING_REPOSITORY}"
                REMOTE_BRANCH="$(git config branch.${CURRENT_BRANCH}.merge | sed -e 's#^[^/]*/[^/]*/##')"
                TARGET="${REMOTE_REPOSITORY}/${REMOTE_BRANCH}"
            fi
        fi

        echo "To: ${TARGET}"
        echo ""

        git log ${TARGET}..
    fi

}
function gswitch(){
    if [ "${1}" == "" ]; then
        echo "git-switch <branch> [--all]"
    fi
    NEW_BRANCH=${1}
    CURRENT_BRANCH=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)

    if [ "${2}" == "--all" ]; then
        git stash save --include-untracked --all autostash &>/dev/null
    else
        git stash save autostash &>/dev/null
    fi

    git checkout ${NEW_BRANCH}

    if [ "$?" == "1" ]; then
        git branch ${NEW_BRANCH}
        git checkout ${NEW_BRANCH}
    fi

    AUTOSTASH=$(git stash list | grep "${NEW_BRANCH}: autostash" | tail -n 1 | cut -d":" -f1)

    if [ "${AUTOSTASH}" != "" ]; then
        git stash apply ${AUTOSTASH} && git stash drop ${AUTOSTASH}
    fi

}
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}
