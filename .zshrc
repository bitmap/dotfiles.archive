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
md() {
  mkdir -p $1
  cd $1
}

# get global and local ip
ip() {
  echo -e "$(dig +short myip.opendns.com @resolver1.opendns.com)\n$(ipconfig getifaddr en0)"
}

# killport
kp() { lsof -n -i4TCP:"$@" | grep LISTEN | tr -s " " | cut -f 2 -d " " | xargs kill -9; }

# clone
clone() {
  git clone "git@github.com:${1}.git"
}

# backup
backup () {
  if [[ -e $1 ]]; then
    echo "Backing up $1..."
    mv $1 $1.backup
  fi
}

# symlink
symlink () {
  echo "Symlinking $1 as $2..."
  ln -sf $1 $2
}

# push new git branch to origin
pushup() {
  local branch=$(git rev-parse --abbrev-ref HEAD)
  echo Pushing to ${branch}
  git push -u origin ${branch}
}

# git status
git_status() {
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  local -a FLAGS
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  # stashed
  if git rev-parse --verify refs/stash &>/dev/null; then
    FLAGS+="%F{8}≡$(git stash list | wc -l | sed 's/^ *//')%f";
  fi;
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

  local -a GIT_INFO
  GIT_INFO+=( "%F{8} %F{magenta}$GIT_LOCATION%f" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j: :)FLAGS}" )
  echo "${(j: :)GIT_INFO}"
}

# prompt
setopt prompt_subst
precmd() {
  # Print a newline before the prompt, unless it's the
  # first prompt in the process.
  if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
    NEW_LINE_BEFORE_PROMPT=1
  elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
    echo ""
  fi
}
NEWLINE=$'\n'
PROMPT='%F{blue}${PWD/#$HOME/~}%f $(git_status) ${NEWLINE}%F{green}$%f '

# This loads nvm
export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# plugins
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
