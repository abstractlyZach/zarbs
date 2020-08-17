#!/usr/bin/env sh

# install all the programs in programs.csv

set -x # echo commands
set -e # exit on failure

echo "Make sure to add your ssh key to github.com and git.autodesk.com"

name="zach"

git_install() {
    program_name="$(basename $1 '.git')"
    target_directory=~/workspace/"$program_name"
    ./clone_or_pull "$1" "$target_directory" 
    cd "$target_directory"
    sudo make clean install
    cd -
}

pacman_install() {
    pacman -Q "$1" 2>/dev/null || \
    pacman --noconfirm --needed --sync "$1" 
}

aur_install() { 
    pacman -Q "$1" 2>/dev/null || \
    sudo -u "$name" yay -S --noconfirm "$1"
}

pip_install() { 
    pip install "$1" 
}

tempfile="${HOME}/.cache/programs.csv"

# ignore the first line (headers)
# https://stackoverflow.com/questions/339483/how-can-i-remove-the-first-line-of-a-text-file-using-bash-sed-script
tail -n +2 manjaro_work_programs.csv | sed '/^#/d' > "${tempfile}"

while IFS="," read -r tag program comment; do
    case "$tag" in
	"G") git_install "$program";;
	"P") pip_install "$program";;
	"A") aur_install "$program";;
	*) aur_install "$program";;
    esac
done < "${tempfile}"

workdir="$HOME/workspace/adsk"
mkdir --parents "$workdir"
cd $workdir
git clone git@git.autodesk.com:plangrid/team-page.git team_page
git clone git@github.com:plangrid/plangrid-insights.git insights
git clone git@github.com:plangrid/gg-project-hub.git project_hub
