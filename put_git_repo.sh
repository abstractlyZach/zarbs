# Downlods a gitrepo $1 and places the files in $2 only overwriting conflicts
name="$(whoami)"
[ -z "$3" ] && branch="master" || branch="$repobranch"
dialog --infobox "Downloading and installing config files..." 4 60
dir=$(mktemp -d)
[ ! -d "$2" ] && mkdir -p "$2"
sudo -u "$name" git clone -b "$branch" --depth 1 "$1" "$dir/gitrepo" >/dev/null 2>&1 &&
sudo -u "$name" cp -rfT "$dir/gitrepo" "$2"
