# .dotfiles

```sh
git clone git@github.com:bitmap/dotfiles.git .dotfiles && cd .dotfiles
```

## Install

Switch your shell to `zsh` to insure all scripts work correctly

```sh
chsh -s $(which zsh)
```

and run the install script

```sh
cd .dotfiles
./setup.sh
```

## Run setup script for macOS

```sh
cd .dotfiles
./mac/setup.sh
./mac/defaults.sh
```

### Brewfile

```sh
brew bundle
```
