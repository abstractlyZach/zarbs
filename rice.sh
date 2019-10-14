name=zach
dotfilesrepo="https://github.com/abstractlyZach/dotfiles.git"

putgitrepo() { # Downlods a gitrepo $1 and places the files in $2 only overwriting conflicts
	[ -z "$3" ] && branch="master" || branch="$repobranch"
	dialog --infobox "Downloading and installing config files..." 4 60
	dir=$(mktemp -d)
	[ ! -d "$2" ] && mkdir -p "$2"
	sudo -u "$name" git clone -b "$branch" --depth 1 "$1" "$dir/gitrepo" >/dev/null 2>&1 &&
	sudo -u "$name" cp -rfT "$dir/gitrepo" "$2"
}

# Install the dotfiles in the user's home directory
putgitrepo "$dotfilesrepo" "/home/$name" "$repobranch"
rm -f "/home/$name/README.md" "/home/$name/LICENSE"
rm -rf "/home/$name/.git/"
rm -f "/home/$name/.config/nvim/autoload/plug.vim"

xrdb $HOME/.Xresources

cd $HOME
# set capslock to escape
sudo sed -i 's/\(\s*key <CAPS>.*\)\(Caps_Lock\)/\1Escape/g' /usr/share/X11/xkb/symbols/pc

# disable sleep on lid-close
# todo: https://unix.stackexchange.com/questions/52643/how-to-disable-auto-suspend-when-i-close-laptop-lid

sudo apt-get install git \
	vim \
	htop \
	xclip \
    	libx11-dev \
	libxft-dev \
	libxext-dev \
	xcb \
	libxcb-keysyms1-dev \
	libxcb-ewmh-dev \
	libxcb-util0-dev \
	libxinerama-dev \
	libxinerama1 \
	libxinerama1-dbg \
	gcc-8 \
	-y

sudo apt-get install curl -y

# gstreamer utility for watching videos on online players
sudo apt-get install \
	libgstreamer1.0-0 \
	gstreamer1.0-plugins-base \
	gstreamer1.0-plugins-good \
	gstreamer1.0-plugins-bad \
	gstreamer1.0-plugins-ugly \
	gstreamer1.0-libav \
	gstreamer1.0-doc \
	gstreamer1.0-tools \
	gstreamer1.0-x \
	gstreamer1.0-alsa \
	gstreamer1.0-gl \
	gstreamer1.0-gtk3 \
	gstreamer1.0-qt5 \
	gstreamer1.0-pulseaudio \
	-y

# for chromecasting stuff
sudo apt-get install mkchromecast -y

# window transparency manager
sudo apt-get install xcompmgr -y

# video player
sudo apt-get install vlc -y

sudo apt-get install python-pip -y
sudo apt-get install virtualenv -y

pip install virtualenvwrapper

sudo apt-get install ranger -y
sudo apt-get install tree -y

# notification daemon
sudo apt-get install dunst -y

# cmdline dialog
sudo apt-get install dialog -y

sudo apt-get install zsh -y 

sudo apt autoremove

sudo snap install spotify

# powerline for vim
pip install powerline-status

mkdir -p workspace
cd workspace

mkdir -p lukesmith
cd lukesmith

git clone https://github.com/LukeSmithxyz/dwm.git
cd dwm
#sed -i 's/^\(XINERAMALIBS\)/#\1/g' config.mk
#sed -i 's/^\(XINERAMAFLAGS\)/#\1/g' config.mk
sed -i 's/^CC = cc$/CC = gcc-8/g' config.mk
sudo make clean install
# I forgot which site I read this on, but it'll make it add the right file to the right place
sudo apt-get install dwm -y
cd ..

git clone https://github.com/LukeSmithxyz/st.git
cd st
sudo make clean install

cd ~/workspace
git clone https://github.com/baskerville/sxhkd.git
cd sxhkd
sudo make clean
sudo make
sudo make install

sudo apt-get install zsh-syntax-highlighting -y

# add new stable version of nvim. for some reason the one on apt uses 0.2.2 which has a bug with cursor shapes in st -_-
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update
sudo apt-get install neovim -y

sudo apt-get install screenkey -y


cd ~
if [ ! -f ~/.xprofile ]; then
	echo "sxhkd &" > ~/.xprofile
fi

