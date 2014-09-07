After cloning:

	# create symlink to .(g)vimrc
	cd ~/
	ln -s ~/.vim/.vimrc ~/.vimrc
	ln -s ~/.vim/.gvimrc ~/.gvimrc

	# create symlink for ftplugin
	cd ~/.vim
	ln -s bundle/sparkup/vim/ftplugin ftplugin

	# init submodules
	git submodule update --init
	
	# updating all bundle plugins
	git submodule foreach git pull origin master

See [Synchronizing plugins with git submodules and pathogen](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/).

