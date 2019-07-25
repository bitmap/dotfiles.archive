#!/usr/bin/env bash

function SYMLINK {
	echo "Symlinking dotfiles..."
	echo ""

	local DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	local FILES=(
		.alias
		.zshrc
		.vimrc
		.gitconfig
		.gitignore
		.inputrc
		.nvm/default-packages
	)

	function VSCODE {
		rm -rf "${1}/snippets"
		ln -vs "${DIR}/.config/Code/User/snippets/" "${1}/snippets"

		rm "${1}/settings.json"
		ln -vs "${DIR}/.config/Code/User/settings.json" "${1}/settings.json"
	}

	for FILE in ${FILES[@]}; do
		# create if doesn't exist
		if [ -e "$FILE" ]; then
			touch $HOME/$FILE
		fi

		# remove old version
		rm -r $HOME/$FILE

		# make new symlink
    ln -vs $DIR/$FILE $HOME/$FILE
	done

	# symlink vscode if it's istalled
	local MACOS=$HOME/"Library/Application Support/Code/User"
	local LINUX=$HOME/.config/Code/User

	if [ -d "$MACOS" ]; then
		VSCODE "$MACOS"
	elif [ -d "$LINUX" ]; then
		VSCODE "$LINUX"
	else echo "Can't find VS Code settings"
	fi

	touch $HOME/.hushlogin

	echo -e "\n...Done."
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	SYMLINK;
else
	read -p "Install dotfiles? This will overwrite files in your home directory [y/n]" -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		SYMLINK;
	fi;
fi;
