After cloning:

	# create symlink to .(g)vimrc
	cd ~
	ln -s ~/.vim/.vimrc ~/.vimrc
	ln -s ~/.vim/.gvimrc ~/.gvimrc

	# init submodules
	git submodule update --init

To update plugins run:
	
	git submodule foreach git pull origin master
	
Use `:Helptags` command to generate help tags for all bundled plugins after cloning or updating.

See [Synchronizing plugins with git submodules and pathogen](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/).

