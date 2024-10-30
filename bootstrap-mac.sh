#/bin/bash

set -x 

# install homebrew

which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing homebrew"
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Brew is already installed"
fi

brew list 1password || brew install --cask 1password
brew list iterm2 || brew install --cask iterm2
brew list alfred || brew install --cask alfred
brew list visual-studio-code || brew install --cask visual-studio-code
brew list google-chrome || brew install --cask google-chrome
brew list rectangle || brew install --cask rectangle
brew list nvm || brew install nvm
brew list tmux || brew install tmux
brew list docker || brew install --cask docker
brew list anki || brew install --cask anki
brew list fd || brew install fd
brew list rg || brew install rg

echo "Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


