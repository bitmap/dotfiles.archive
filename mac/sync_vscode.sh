#!/bin/zsh

function linked() {
  print -P "%F{6}Linked%f ${1}"
}

function err() {
  print -P "%F{1}Error!%f ${1}"
}

function copy_vscode_settings() {
  local DOTFILES_DIR="$HOME/.dotfiles"
  snippets="${1}/snippets"
  settings="${1}/settings.json"

  # create settings file and snippets dir if they don't exist
  touch "$settings"

  if [ ! -d "$snippets" ]; then
    mkdir "$snippets"
  fi

  #symlink settings
  rm "$settings"
  (ln -s "$DOTFILES_DIR/.config/Code/User/settings.json" "$settings" && linked "VS Code Settings") || err "Error linking VS Code Settings"

  #symlink snippets
  rm -rf "$snippets"
  (ln -s "$DOTFILES_DIR/.config/Code/User/snippets/" "$snippets" && linked "VS Code Snippets") || err "Error linking VS Code Snippets"
}

# symlink vscode if it's installed
macOS_dir=$HOME/"Library/Application Support/Code/User"
linux_dir=$HOME/.config/Code/User

is_linux () { [[ "$OSTYPE" == *'linux'* ]]; }
is_macOS () { [[ "$OSTYPE" == *'darwin'* ]]; }

if is_macOS && [ -d "$macOS_dir" ]; then
  copy_vscode_settings "$macOS_dir"
elif is_linux && [ -d "$linux_dir" ]; then
  copy_vscode_settings "$linux_dir"
else
  err "Can't find VS Code settings"
fi
