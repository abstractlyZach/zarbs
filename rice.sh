#!/usr/bin/env sh

# exit on errors
set -e

alias clone_or_pull=$(realpath clone_or_pull)
dotfiles_repo="https://github.com/abstractlyZach/dotfiles.git"


# prompt user for sudo immediately instead of having to wait
# using this approach because I don't know a better one
sudo ls >/dev/null

# disable sleep on lid-close
# todo: https://unix.stackexchange.com/questions/52643/how-to-disable-auto-suspend-when-i-close-laptop-lid

# add new stable version of nvim. for some reason the one on apt uses 0.2.2 which has a bug with cursor shapes in st -_-
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update

./install_programs

sudo snap install spotify
sudo apt autoremove

pip install virtualenvwrapper


# Install the dotfiles in the user's home directory
config_directory="$HOME/.config"
clone_or_pull "$dotfiles_repo" "$config_directory"
cd "$config_directory"
make

# load the Xresources file
xrdb $HOME/.Xresources

# set capslock to escape
sudo sed -i 's/\(\s*key <CAPS>.*\)\(Caps_Lock\)/\1Escape/g' /usr/share/X11/xkb/symbols/pc


mkdir -p ~/workspace/lukesmith

dwm_dir=~/workspace/lukesmith/dwm
clone_or_pull "https://github.com/LukeSmithxyz/dwm.git" "$dwm_dir" 
cd "$dwm_dir"
sed -i 's/^CC = cc$/CC = gcc-8/g' config.mk
sudo make clean install
# I forgot which site I read this on, but it'll make it add the right file to the right place
sudo apt-get install dwm -y

st_dir=~/workspace/lukesmith/st
clone_or_pull "https://github.com/LukeSmithxyz/st.git" "$st_dir"
cd "$st_dir"
sudo make clean install

sxhkd_dir=~/workspace/sxhkd
clone_or_pull "https://github.com/baskerville/sxhkd.git" "$sxhkd_dir"
cd "$sxhkd_dir"
sudo make clean
sudo make
sudo make install

clone_or_pull "git@github.com:abstractlyZach/utils.git" ~/bin


echo "Complete!"
echo
