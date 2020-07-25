# install neovim and nodejs (nodejs for coc.nvim)
sudo pacman -S nodejs neovim;

mkdir -p ~/.config/nvim;

# install vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';

# install init.vim
cp ../neovim/init.vim ~/.config/nvim/init.vim;

# install vim plug plugins
nvim +PlugInstall;

echo "nvim config installed";
