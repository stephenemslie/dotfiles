dotfiles
========

My dotfiles

	git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
	printf '\nalias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"' >> $HOME/.bashrc
	source $HOME/.bashrc
	homeshick clone https://github.com/stephenemslie/dotfiles.git
	vim +BundleInstall +qall
	
