#!/usr/bin/env sh

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

./install_mac_programs


brew services start skhd
brew services start yabai
