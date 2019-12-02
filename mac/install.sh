#!/usr/bin/env bash

tools=(
  git
  diff-so-fancy
  ffmpeg
  imagemagick
  wget
  youtube-dl
  zsh-autosuggestions
  zsh-syntax-highlighting
)

apps=(
  1password
  a-better-finder-rename
  applepi-baker
  balenaetcher
  docker
  figma
  firefox
  google-chrome
  handbrake
  imageoptim
  iterm2
  postman
  sketch
  slack
  sequel-pro
  spectacle
  spotify
  the-unarchiver
  transmission
  transmit
  visual-studio-code
  vlc
)

sudo -v

# Keep-alive sudo
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "Installing Xcode command line tools"
xcode-select --install

echo "Installing Homebrew..."
echo | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing NVM"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

echo "Installing Python..."
brew install python
sudo easy_install pip

echo "Installing misc dev tools..."
for tool in ${tools[@]}; do brew install $tool; done

echo "Installing Apps..."
for app in ${apps[@]}; do brew cask install $app; done

echo "Installing Fonts..."
brew tap homebrew/cask-fonts
brew cask install font-fira-code

source ./setup.sh -f

read -p "Finished install. I recommend a restart. Restart now? (y/n)" -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  osascript -e 'tell app "System Events" to restart'
fi
