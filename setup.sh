#!/bin/zsh

local DOTFILES_DIR="$HOME/.dotfiles"

if [[ "$PWD" != "$HOME/.dotfiles" ]]; then
  print -P "%F{1}Error!%f Run script %F{4}./install%f from %F{3}$DOTFILES_DIR%f"
  exit 1
fi

function install() {
  local function printSuccess() {
    print -P "%F{6}Linked%f ${1}"
  }

  local function printError() {
    print -P "%F{1}Error!%f ${1}"
  }

  local function makeDirs() {
    local dirs=(
      $HOME/.vim/undo
      $HOME/dev
      $HOME/scratch
    )

    for newdir in ${dirs[@]}; do

    if [ ! -d "$newdir" ]; then
      mkdir "$newdir"
    fi
    done
  }

  echo ""

  local files=(
    .zshrc
    .vimrc
    .gitattributes
    .gitconfig
    .gitignore
    .nvm/default-packages
  )

  print -P "%F{3}Symlinking%f from %F{4}$DOTFILES_DIR%f"

  # symlink bin
  rm "$HOME/bin"
  ln -s "$DOTFILES_DIR/bin" "$HOME/bin" && printSuccess "~/bin"

  for file in ${files[@]}; do
    local src=$DOTFILES_DIR/$file
    local dest=$HOME/$file

    # remove old version
    if [ -f "$dest" ]; then
      rm -rf "$dest"
    fi

    # make new symlink
    if [ -f "$src" ]; then
      (ln -s "$src" "$dest" && printSuccess "~/$file") || printError "Couldn't link %F{5}${file}%f"
    else
      printError "$src doesn't exist"
    fi
  done

  touch $HOME/.hushlogin
  makeDirs

  print -P "%F{2}...Done!%f"
}

if [ "$1" = "--force" -o "$1" = "-f" ]; then
  install
else
  read "reply?This will overwrite files in your home directory. Continue? "
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    install
  fi
fi
