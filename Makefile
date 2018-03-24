PWD=$(shell pwd)

RM=rm -f
DATE=$(shell date "+%Y%m%d")


install:clean
	@ln -sf $(PWD)/bashrc  ~/.bashrc
	@ln -sf $(PWD)/gitconfig  ~/.gitconfig
	@ln -sf $(PWD)/pip  ~/.pip
	@ln -sf $(PWD)/quiltrc  ~/.quiltrc
	@ln -sf $(PWD)/tmux  ~/.tmux
	@ln -sf $(PWD)/vim   ~/.vim
	@ln -sf .vim/vimrc   ~/.vimrc
	@ln -sf $(PWD)/zshrc ~/.zshrc
	@if [ -d ~/.notes  -a ! -d ~/.ssh ];then \
			ln -sf .notes/.ssh ~/.ssh; \
		elif [ -d ~/.notes  -a -d ~/.ssh ];then \
			echo warning: ~/.ssh directory is exist.; \
		fi
	@if [ -d ~/.notes  -a ! -d ~/.gnupg ];then \
			ln -sf .notes/.gnupg ~/.gnupg; \
			echo ln; \
		elif [ -d ~/.notes -a -d ~/.gnupg ];then \
			echo warning: ~/.gnupg directory is exist.; \
		fi
	@if [ -d ~/.notes ];then \
		ln -sf .notes/.ossutilconfig ~/.ossutilconfig; \
		mkdir -p ~/.qshell
		ln -sf .notes/.qshell_account.json ~/.qshell/account; \
		fi

clean:
	@$(RM) ~/.bashrc ~/.gitconfig ~/.quiltrc ~/.vim ~/.vimrc ~/.zshrc  ~/.pip ~/.tmux
