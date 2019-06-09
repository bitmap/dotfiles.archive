# aliases
source $HOME/.alias
alias zrc="source ~/.zshrc"

# enable zsh colors
autoload -U colors && colors

# autocompletion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# mkdir and cd function
md () {
  mkdir -p $1
  cd $1
}

# get global and local ip
ip () {
  echo -e "$(dig +short myip.opendns.com @resolver1.opendns.com)\n$(ipconfig getifaddr en0)"
}

# killport
killport () { lsof -n -i4TCP:"$@" | grep LISTEN | tr -s " " | cut -f 2 -d " " | xargs kill -9; }

# git status
git_status() {
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  local -a FLAGS
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  # merging
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+="%F{red}!!%f"
  fi
  # staged
  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+="%F{green}±$(git diff --cached --numstat | wc -l | sed 's/^ *//')%f"
  fi
   # modified
  if ! git diff --quiet 2> /dev/null; then
    FLAGS+="%F{yellow}•$(git diff-files --ignore-submodules --shortstat | sed -E 's/.* ([0-9]+) file.*/\1/')%f"
  fi
  # untracked
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+="%F{cyan}?$(git ls-files --others --exclude-standard | wc -l | sed 's/^ *//')%f"
  fi
  # stashed
  if git rev-parse --verify refs/stash &>/dev/null; then
    FLAGS+="%F{magenta}⚑$(git stash list | wc -l | sed 's/^ *//')%f";
  fi;

  local -a GIT_INFO
  GIT_INFO+=( " %F{white}$GIT_LOCATION%f" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j: :)FLAGS}" )
  echo "${(j: :)GIT_INFO}"
}

# prompt
setopt prompt_subst
precmd() { print "" }
NEWLINE=$'\n'
PROMPT='%F{blue}${PWD/#$HOME/~}%f $(git_status) ${NEWLINE}%F{white}$%f '

# This loads nvm
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
