# .dotfiles

```sh
git clone git@github.com:bitmap/.dotfiles.git && cd .dotfiles
```

## Install

Switch your shell to `zsh` to insure all scripts work correctly

```sh
chsh -s $(which zsh)
```

and run the install script

```sh
cd .dotfiles
./install
```

## Run setup script for macOS

```sh
cd .dotfiles
./mac/install
./mac/defaults
```

### Brewfile

```sh
brew bundle --file ./mac/Brewfile
```
