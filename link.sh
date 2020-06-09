#!/usr/bin/env fish

#Setup script for Dotfiles
echo -e "Setting up Dotfiles..."

echo -e " Select an option:"
echo -e "  (1) Setup symlinks"
echo -e "  (2) Install vim plugins"
echo -e "  (3) Install iTerm2 Integration"
echo -e "  (4) Undo symlinks"
echo -e "  (0) Exit"

read -P "==> " -l option

switch $option
  case "1"
    echo -e " Adding symlinks..."
    touch ~/.env
    mv ~/.vimrc ~/.vimrc.old
    mv ~/.ssh/config ~/.ssh/config.old
    mv ~/.config/fish ~/.config/fish.old
    mv ~/.gitconfig ~/.gitconfig.old
    mv ~/.asdfrc ~/.asdfrc.old

    ln -sfnv "$PWD/vimrc" ~/.vimrc
    ln -sfnv "$PWD/sshconfig" ~/.ssh/config
    ln -sfnv "$PWD/fishconfig" ~/.config/fish
    ln -sfnv "$PWD/gitconfig" ~/.gitconfig
    ln -sfnv "$PWD/asdfrc" ~/.asdfrc
  case "2"
    echo -e " Installing vim plugins... "
    mkdir -p ~/.vim/swapfiles
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginUpdate +qall
  case "3"
    echo -e " Installing iTerm2 shell integration... "
    curl -L https://iterm2.com/shell_integration/fish -o ~/.iterm2_shell_integration.fish
  case "4"
    echo -e " Removing symlinks..."
    unlink ~/.vimrc
    unlink ~/.ssh/config
    unlink ~/.config/fish
    unlink ~/.gitconfig
    unlink ~/.asdfrc

    mv ~/.vimrc.old ~/.vimrc
    mv ~/.ssh/config.old ~/.ssh/config
    mv ~/.config/fish.old ~/.config/fish
    mv ~/.gitconfig.old ~/.gitconfig
    mv ~/.asdfrc.old ~/.asdfrc
  case "0"
    echo -e " Bye! "
    exit 0
  case '*'
    echo -e " Invalid option entered! "
    exit 1
end

exit 0
