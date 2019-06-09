# .dotfiles

## Setup

Prerequisites:
- [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)
- [iTerm](https://iterm2.com/downloads.html)
- [Visual Studio Code](https://code.visualstudio.com/download)

Run scripts:
```sh
# change shell to zsh
chsh -s $(which zsh)

# install Xcode command-line tools
xcode-select --install

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install python
brew install python
sudo easy_install pip

# install misc tools
brew install ffmpeg diff-so-fancy thefuck
brew install yarn --ignore-dependencies

# install nvm and node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
nvm install node
nvm alias default node

# symlink dotfiles
git clone git@github.com:bitmap/.dotfiles.git && cd .dotfiles
./setup

# setup macOS preferences
./macos
```
## Notes

- Link iTerm prefs to `~/.dotfiles/.config/iTerm`
- Install [Fire Code](https://github.com/tonsky/FiraCode) fonts
