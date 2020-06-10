#!/bin/bash

mkdir $HOME/bin

# stuff I use
sudo apt install -y guake fish vim-gtk chromium-browser xclip gnome-tweak-tool jq curl nginx screen

# ruby dependencies
libssl-dev libreadline-dev zlib1g-dev

# other work packages
sudo apt install -y postgresql postgresql-contrib libpq-dev redis libxml2-dev

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
$HOME/.asdf/asdf.sh
asdf plugin add ruby
asdf plugin add nodejs
mkdir -p ~/.config/fish/completions
cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions

# for git diffs
git clone git@github.com:so-fancy/diff-so-fancy.git
cp diff-so-fancy/diff-so-fancy $HOME/bin/
cp -r diff-so-fancy/lib/ $HOME/bin/
rm -rf diff-so-fancy

# slack
curl "https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb" -o slack.deb
sudo apt install -y ./slack.deb
rm slack.deb

# terraform
curl "https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip" -o terraform.zip
unzip terraform.zip -d ~/bin | yes
rm terraform.zip

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# postgres
sudo -y postgres createuser -s dan

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf ./aws
rm awscliv2.zip
