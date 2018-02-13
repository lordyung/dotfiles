#!/usr/bin/env bash

# Install homebrew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | sed 's|https://github.com/Homebrew/brew|https://mirrors.ustc.edu.cn/brew.git|g' | sed 's|https://github.com/Homebrew/homebrew-core|https://mirrors.ustc.edu.cn/homebrew-core.git|g')"

# Install taps

if [ ! -d $(brew --repo caskroom/cask) ]; then
    git clone https://mirrors.ustc.edu.cn/homebrew-cask.git $(brew --repo caskroom/cask)
fi
brew tap homebrew/dupes
brew tap homebrew/nginx
brew tap homebrew/php

# Make sure we’re using the latest Homebrew and Upgrade any already-installed formulae
# brew update
# brew upgrade


# brew install android-platform-tools
# brew install bash
# brew install bash-completion2
# brew install mysql #restart_service: true, conflicts_with: [homebrew/versions/mysql56]
# brew install php56 --with-gmp
# brew install php71 --with-imap
brew install ack
brew install aircrack-ng
brew install aria2
brew install autoconf
brew install automake
brew install bash
brew install bfg
brew install binutils
brew install binwalk # Work on automating classical cipher cracking in C
brew install boost
brew install calc
brew install cifer
brew install composer
brew install coreutils --build-from-source --with-gmp
brew install cscope
brew install ctags 
brew install the_silver_searcher
brew install curl
brew install e2fsprogs
brew install dark-mode
brew install dex2jar
brew install diffutils
brew install dns2tcp
brew install ed --with-default-names
brew install emacs --with-cocoa --with-gnutls
brew install entr # run this script when this file changes guy.
brew install exiv2
brew install fcrackzip
brew install ffmpeg
brew install file-formula
brew install findutils --with-default-names # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install foremost
brew install fzf
brew install gawk
brew install gdb  # gdb requires further actions to make it work. See `brew info gdb`.
brew install git
brew install git-lfs
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names # Install GNU `sed`, overwriting the built-in `sed`
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install gpatch
brew install grc # generic colouriser
brew install grep --with-default-names
brew install gzip
brew install hashpump
brew install hub # github util. gotta love `hub fork`, `hub create`, `hub checkout <PRurl>`
brew install hydra
brew install imagemagick --with-webp
brew install john
brew install knock
brew install less
brew install lua
brew install lynx
brew install m4
brew install make
brew install mas # A simple command line interface for the Mac App Store.
brew install moreutils # Install some other useful utilities like `sponge`.
brew install mtr # mtr - ping & traceroute. best.
brew install nano
brew install ncdu # find where your diskspace went
brew install nmap
brew install node # This installs `npm` too using the recommended installation method
brew install openssh
brew install openssl
brew install optipng
brew install p7zip
brew install perl
brew install pidcat   # colored logcat guy
brew install pigz
brew install pngcheck
brew install postgresql
brew install pv
brew install python
brew install readline
brew install rename
brew install rsync
brew install screen
brew install shpotify
brew install socat
brew install speedtest_cli
brew install sqlmap
brew install ssh-copy-id
brew install svn
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install terminal-notifier
brew install testssl
brew install the_silver_searcher
brew install tree
brew install ucspi-tcp # `tcpserver` etc
brew install unzip
brew install vbindiff
brew install vim --with-override-system-vi --with-lua
brew install watch
brew install wdiff --with-gettext
brew install webkit2png
brew install wget
brew install xz
brew install z # z hopping around folders
brew install zopfli
brew install zsh

# Install Casks
brew cask install alfred
# brew cask install baidunetdisk
brew cask install caffeine
brew cask install calibre
brew cask install dash
brew cask install flux
# brew cask install folx
brew cask install google-chrome
brew cask install istat-menus
brew cask install iterm2
brew cask install java
brew cask install kindle
brew cask install neteasemusic
brew cask install qq
# brew cask install sequel-pro
# brew cask install shadowsocksx-ng
brew cask install sizeup
brew cask install skim
# brew cask install sublime-text
brew cask install the-unarchiver
brew cask install thunder
brew cask install vlc
brew cask install youdao
brew cask install appcleaner
brew cask install cheatsheet
brew cask install mplayerx
brew cask install macdown
brew cask install moom
brew cask install popclip
# brew cask install xee

# allow mtr to run without sudo
mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//')
sudo chmod 4755 $mtrlocation/sbin/mtr
sudo chown root $mtrlocation/sbin/mtr

# brew cleanup # Remove outdated versions from the cellar
