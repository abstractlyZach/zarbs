set -e
source "$HOME/.local/bin/virtualenvwrapper.sh"
lsvirtualenv | grep "nvim" || mkvirtualenv nvim
workon nvim
pip install neovim
