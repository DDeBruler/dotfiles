#!/bin/bash

mkdir -p $HOME/bin

# stuff I use
sudo apt install -y guake fish vim-gtk chromium-browser xclip gnome-tweak-tool jq curl nginx screen

# ruby dependencies
libssl-dev libreadline-dev zlib1g-dev

# other work packages
sudo apt install -y postgresql postgresql-contrib libpq-dev redis libxml2-dev

# asdf
if ! command -v asdf &> /dev/null; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
  $HOME/.asdf/asdf.sh
  asdf plugin add ruby
  asdf plugin add nodejs
  mkdir -p ~/.config/fish/completions
  cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
fi

# for git diffs
if ! command -v diff-so-fancy &> /dev/null; then
  git clone git@github.com:so-fancy/diff-so-fancy.git
  cp diff-so-fancy/diff-so-fancy $HOME/bin/
  cp -r diff-so-fancy/lib/ $HOME/bin/
  rm -rf diff-so-fancy
fi

# slack
if ! command -v slack &> /dev/null; then
  curl "https://downloads.slack-edge.com/linux_releases/slack-desktop-4.9.1-amd64.deb" -o slack.deb
  sudo apt install -y ./slack.deb
  rm slack.deb
fi

# terraform
if ! command -v terraform &> /dev/null; then
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt-get update && sudo apt-get install terraform
fi

# postgres
sudo -y postgres createuser -s dan

# AWS CLI
if ! command -v aws &> /dev/null; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm -rf ./aws
  rm awscliv2.zip
fi

# Zoom
if ! command -v zoom &> /dev/null; then
  curl "https://zoom.us/client/latest/zoom_amd64.deb" -L -o zoom.deb
  sudo apt install -y ./zoom.deb
  rm zoom.deb
fi
