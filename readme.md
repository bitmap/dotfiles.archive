# .files
These are my preferences.

----------
## Setup

- Install Xcode + command-line tools (this also installs `git`)
- Install [iTerm](https://www.iterm2.com/downloads.html)
- Install [Atom](https://atom.io/download/mac)
- Install `brew`
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
- Install `nvm`
```sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
```
- Install `node`
```sh
nvm install node

### install LTS version and set as default
nvm install --lts
nvm alias default lts/*
```
- Setup dotfiles
```sh
git clone https://github.com/bitmap/dotfiles
cd dotfiles
./setup.sh
```
- Setup macOS
```sh
./.macos
```
----------
## Notes
- Install Source Code Pro from fonts
- Link iTerm preferences to `~/dotfiles/iterm/com.googlecode.iterm2.plist`
- Install starred Atom packages `apm stars --install`
