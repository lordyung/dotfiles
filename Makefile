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

clean:
	@$(RM) ~/.bashrc ~/.gitconfig ~/.quiltrc ~/.vim ~/.vimrc ~/.zshrc  ~/.pip ~/.tmux
