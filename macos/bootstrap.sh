#!/bin/zsh

local DOTS="$HOME/.dotfiles"

if [[ "$PWD" != "$HOME/.dotfiles" ]]; then
	print -P "%F{1}Error!%f Run script %F{4}./setup-macos%f from %F{3}$DOTS%f"
	exit 1
fi

sudo -v

# Keep-alive sudo
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "\nInstalling Xcode command line tools"
xcode-select --install

echo "\nInstalling Homebrew..."
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "\nInstalling NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash

echo "\nInstalling Apps and dev tools..."
brew bundle --file ./macos/Brewfile

echo "\nInstalling Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "\nSymlinking settings..."
source ./setup.sh -f

echo "\nLinking iTerm preferences..."
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTS/macos/iterm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# macOS defaults
source ./macos/defaults.sh

echo "\nFinished install. Please restart."
