#!/usr/bin/env sh

set -e # exit on errors
set -x # echo commands

config_directory="$HOME/.config"
dotfiles_repo="https://github.com/abstractlyZach/dotfiles.git"
# alias this command to the script in this directory
alias clone_or_pull=$(realpath clone_or_pull)

# install homebrew
# THE OSX package manager: https://brew.sh/
if brew -h >/dev/null 2>&1; then
	echo "homebrew already installed!";
else
	echo "homebrew not installed! Installing now...";
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# get facebook messaging on the command line
# need to remove .kryptonite file if convos aren't loading:
# 	https://github.com/Alex-Rose/fb-messenger-cli/issues/199
#npm install -g fb-messenger-cli --registry https://registry.npmjs.org


# change workspace hotkeys to option-#

# turn off workspace slide animation
# Accessibility > Display > reduce motion

# install Ubersicht
# turn on scripting support with ScriptEditor 
# https://github.com/felixhageloh/uebersicht
# (Scripting Support section)

./osx_install_programs

# add python support for nvim
python3 -m pip install --user --upgrade pynvim

# Install the dotfiles in the user's home directory
clone_or_pull "$dotfiles_repo" "$config_directory"
cd "$config_directory"
make osx

brew services start skhd
brew services start yabai

clone_or_pull "git@github.com:abstractlyZach/utils.git" ~/bin

echo "Complete!"
echo
