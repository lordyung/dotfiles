SUBDIR=bashrc bin gitconfig gnupg ossutilconfig pip qshell quiltrc vim zsh tmux ssh/config.default
PWD=$(shell pwd)

RM=rm -f
DATE=$(shell date "+%Y%m%d")


install:clean vim/vimrc zsh/zshrc tmux/tmux.conf
	@for file in $(SUBDIR); \
		do \
		  ln -sf $(PWD)/$${file} ~/.$${file}; \
		done
	@ln -sf .zsh/zshrc ~/.zshrc
	@ln -sf .vim/vimrc ~/.vimrc
	@ln -sf /usr/local/var/www ~/www

clean:
	@for file in $(SUBDIR); \
		do \
		  $(RM) ~/.$${file}; \
		done
	@$(RM) ~/.zshrc
	@$(RM) ~/.vimrc
	@$(RM) ~/www

vim/vimrc:
	@git submodule init
	@git submodule update
	@git submodule foreach git checkout develop

zsh/zshrc:
	@git submodule init
	@git submodule update
	@git submodule foreach git checkout develop

tmux/tmux.conf:
	@git submodule init
	@git submodule update
	@git submodule foreach git checkout develop

status:
	@git submodule foreach git status




