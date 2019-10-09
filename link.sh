#!/bin/bash

#Setup script for Dotfiles
echo -e "\u001b[32;1m Setting up Dotfiles...\u001b[0m"

echo -e " \u001b[37;1m\u001b[4mSelect an option:\u001b[0m"
echo -e "  \u001b[34;1m (1) Setup symlinks \u001b[0m"
echo -e "  \u001b[34;1m (2) Install vim plugins \u001b[0m"
echo -e "  \u001b[34;1m (2) Undo symlinks \u001b[0m"
echo -e "  \u001b[31;1m (0) Exit \u001b[0m"
echo -en "\u001b[32;1m ==> \u001b[0m"

read -r option

case $option in
  "1")echo -e "\u001b[36;1m Adding symlinks...\u001b[0m"
      mv ~/.vimrc ~/.vimrc.old
      mv ~/.ssh/config ~/.ssh/config.old
      mv ~/.config/fish ~/.config/fish.old
      mv ~/.gitconfig ~/.gitconfig.old

      ln -sfnv "$PWD/vimrc" ~/.vimrc
      ln -sfnv "$PWD/sshconfig" ~/.ssh/config
      ln -sfnv "$PWD/fishconfig" ~/.config/fish
      ln -sfnv "$PWD/gitconfig" ~/.gitconfig

  "2")echo -e "\u001b[7m Installing vim plugins... \u001b[0m"
      git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
      vim +PluginUpdate +qall
      ;;

  "3")echo -e "\u001b[36;1m Adding symlinks...\u001b[0m"
      unlink ~/.vimrc
      unlink ~/.ssh/config
      unlink ~/.config/fish
      unlink ~/.gitconfig

      mv ~/.vimrc.old ~/.vimrc
      mv ~/.ssh/config.old ~/.ssh/config
      mv ~/.config/fish.old ~/.config/fish
      mv ~/.gitconfig.old ~/.gitconfig

  "0")echo -e "\u001b[32;1m Bye! \u001b[0m"
      exit 0
      ;;

  *)echo -e "\u001b[31;1m Invalid option entered! \u001b[0m"
      exit 1
      ;;
esac

exit 0
