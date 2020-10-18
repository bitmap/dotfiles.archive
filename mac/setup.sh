#!/bin/zsh

local DOTS="$HOME/.dotfiles"

if [[ "$PWD" != "$HOME/.dotfiles" ]]; then
	print -P "%F{1}Error!%f Run script %F{4}./mac/install%f from %F{3}$DOTS%f"
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
echo | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "\nInstalling NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

echo "\nInstalling Apps and dev tools..."
brew bundle

echo "\nSymlinking settings..."
source ./setup.sh -f

echo "\nLinking iTerm preferences..."
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/.config/iTerm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

read "reply?\nFinished install. I recommend a restart. Restart now? (y/n)" -n 1
echo ""
if [[ "$reply" =~ ^[Yy]$ ]]; then
  osascript -e 'tell app "System Events" to restart'
fi
