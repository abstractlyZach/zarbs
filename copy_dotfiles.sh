dotfiles_repo="https://github.com/abstractlyZach/dotfiles.git" 
name=$(whoami)
./put_git_repo.sh "$dotfiles_repo" "/home/$name"

