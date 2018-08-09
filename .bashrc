# color ls
alias ls="command ls -G"
alias l="ls -lF -G" # all files, in long format
alias la="ls -laF -G" # all files inc dotfiles, in long format
alias lsd="ls -lF -G | grep '^d'" # only directories
alias ll="ls -alS"

# quick clear
alias x="clear"

# quick nav
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# sudo alias
alias sudo="sudo "

# git aliases
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit -m" # requires you to type a commit message
alias gco="git checkout"
alias gd="git diff -w"
alias gf="git fetch"
alias gg="git push"
alias ggg="git push --set-upstream origin"
alias glg="git log --oneline --decorate --all --graph"
alias gnb="git checkout -b"
alias gp="git pull"
alias gs="git status"

# npm aliases
alias nf="npm cache clean && rm -rf node_modules && npm install"
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install --global"
alias nit="npm install && npm test"
alias nk="npm link"
alias nl="npm lits --depth=0"
alias nlg="npm list --global --depth=0"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"

# put computer to sleep
alias zz="pmset displaysleepnow"
alias zzz="pmset sleepnow"

# restart
alias ugh="osascript -e 'tell app \"System Events\" to restart'"

# update hosts
alias update-hosts="cd ~/hosts/; git pull; python updateHostsFile.py"

# upgrade node/npm to latest
alias update-node="nvm install node --latest-npm --reinstall-packages-from=node"
alias update-node-lts="nvm install --lts --latest-npm --reinstall-packages-from='lts/*'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# print PATH entries
alias path='echo -e ${PATH//:/\\n}'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias lip="ipconfig getifaddr en0"

# Own the files in this directory *DANGERZONE*
alias gimme="chmod -R u+x ."

# mkdir and cd function
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# kill port
function killport () { lsof -n -i4TCP:"$@" | grep LISTEN | tr -s " " | cut -f 2 -d " " | xargs kill -9; }

# clone from "github.com/bitmap"
function bitmap () { git clone https://github.com/bitmap/"$@".git; }

# PATH for npm [deprecated - use nvm instead]
# export PATH="$HOME/.npm-packages/bin:$PATH"

# This loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Prompt
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM="gnome-256color";
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM="xterm-256color";
fi;

prompt_git() {
  local status="";
  local branchName="";

  # Check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == "0" ]; then

    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then

      # Ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null;

      # Check for uncommitted changes in the index.
      if ! $(git diff --quiet --ignore-submodules --cached); then
        status+="+";
      fi;

      # Check for unstaged changes.
      if ! $(git diff-files --quiet --ignore-submodules --); then
        status+="*";
      fi;

      # Check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        status+="…";
      fi;

      # Check for stashed files.
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        status+="#";
      fi;

    fi;

    # Get the short symbolic ref.
    # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
    # Otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
    git rev-parse --short HEAD 2> /dev/null || \
    echo '(unknown)')";

    [ -n "${status}" ] && status=" [${status}]";

    echo -e "${1}${branchName}${2}${status}";
  else
    return;
  fi;
}

if tput setaf 1 &> /dev/null; then
  tput sgr0; # reset colors
  bold=$(tput bold);
  reset=$(tput sgr0);
  black=$(tput setaf 0);
  red=$(tput setaf 1);
  green=$(tput setaf 2);
  yellow=$(tput setaf 3);
  blue=$(tput setaf 4);
  magenta=$(tput setaf 5);
  cyan=$(tput setaf 6);
  white=$(tput setaf 15);
else
  bold="";
  reset="\e[0m";
  black="\e[1;30m";
  red="\e[1;31m";
  green="\e[1;32m";
  yellow="\e[1;33m";
  blue="\e[1;34m";
  magenta="\e[1;35m";
  cyan="\e[1;36m";
  white="\e[1;37m";
fi;

# Set the terminal title and prompt.
PS1="\n\[${cyan}\]\w"; # working directory full path
PS1+="\$(prompt_git \"\[${reset}\] @ \[${yellow}\]\" \"\[${magenta}\]\")"; # Git repository details
PS1+="\n\[${green}\]$ \[${reset}\]"; # prompt
export PS1;

PS2="\[${green}\]› \[${reset}\]";
export PS2;

# fuck
eval "$(thefuck --alias)"
