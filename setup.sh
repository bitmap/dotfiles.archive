#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function sync_dotfiles() {
	rsync --exclude ".git/" \
    --exclude "fonts/" \
    --exclude "iterm/" \
		--exclude ".DS_Store" \
		--exclude ".macos" \
		--exclude "setup.sh" \
		--exclude "readme.md" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	sync_dotfiles;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		sync_dotfiles;
	fi;
fi;
unset sync_dotfiles;
