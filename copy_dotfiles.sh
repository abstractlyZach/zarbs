dotfiles_repo="https://github.com/abstractlyZach/dotfiles.git" 
name=$(whoami)
home_dir="/home/$name"
./put_git_repo.sh "$dotfiles_repo" "$home_dir"
cd "$home_dir"
rm README.md
