# .files
These are my preferences.

----------
## Setup

- Install Xcode + command-line tools (this also installs `git`)
- Install [iTerm](https://www.iterm2.com/downloads.html)
- Install [Atom](https://atom.io/download/mac)
- Install `brew`
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
- Install `nvm`
```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
```
- Install `node`
```
nvm install node
```
- Setup dotfiles
```
git clone https://github.com/bitmap/dotfiles
cd dotfiles
./setup.sh
```
- Setup macOS
```
./.macos
```
----------
## Notes
- Install Source Code Pro from fonts
- Link iTerm preferences to `~/dotfiles/iterm/com.googlecode.iterm2.plist`
- Install starred Atom packages `apm stars --install`
