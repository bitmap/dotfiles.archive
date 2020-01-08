#!/usr/bin/env bash

is_linux () { [[ "$OSTYPE" == *'linux'* ]]; }
is_macOS () { [[ "$OSTYPE" == *'darwin'* ]]; }

function SYMLINK() {
	echo "Symlinking dotfiles..."
	echo ""

	local DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
	local FILES=(
		.alias
		.zshrc
		.vimrc
		.gitconfig
		.gitignore
		.inputrc
		.nvm/default-packages
	)

	function copy_vscode_settings() {
		local SNIPPETS="${1}/snippets"
		local SETTINGS="${1}/settings.json"

		# create settings file if it doesn't exist
		touch "${SETTINGS}"

		#symlink settings
		rm "${SETTINGS}"
		ln -vs "${DIR}/.config/Code/User/settings.json" "${SETTINGS}"

		#symlink snippets
		rm -rf "${SNIPPETS}"
		ln -vs "${DIR}/.config/Code/User/snippets/" "${SNIPPETS}"
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
	local macOS_dir=$HOME/"Library/Application Support/Code/User"
	local linux_dir=$HOME/.config/Code/User

	if is_macOS && [ -d "$macOS_dir" ]; then
		copy_vscode_settings "$macOS_dir"
	elif is_linux && [ -d "$linux_dir" ]; then
		copy_vscode_settings "$linux_dir"
	else
		echo "Can't find VS Code settings"
	fi

	touch $HOME/.hushlogin

	echo -e "\n...Done."
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	SYMLINK
else
	read -p "Install dotfiles? This will overwrite files in your home directory [y/n]" -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		SYMLINK
	fi
fi
