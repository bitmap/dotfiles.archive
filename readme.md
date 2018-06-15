# .dotfiles
These are my preferences.

----------
## Setup

- Install Xcode + command-line tools (this also installs `git`)
- Install [iTerm](https://www.iterm2.com/downloads.html)
- Install [VS Code](https://code.visualstudio.com/download)
- Install [Homebrew](https://brew.sh/)
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
- Install [nvm](https://github.com/creationix/nvm)
```sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
```
- Install `node` with `nvm`
```sh
nvm install node
nvm alias default node

### OPTIONAL - install LTS version and set as default
nvm install --lts
nvm alias default lts/*
```
- Install Yarn (exclude Node.js, prefer nvm)
```sh
brew install yarn --without-node
```
- Setup dotfiles
```sh
git clone https://github.com/bitmap/dotfiles .dotfiles
cd .dotfiles
./setup
```
- Setup macOS
```sh
./.macos
```
----------
## Notes

- Install Hack fonts
- Link iTerm prefs to `~/.dotfiles/iterm/com.googlecode.iterm2.plist`
