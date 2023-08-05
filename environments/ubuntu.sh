#!/bin/bash

### INSTALL PACKAGES

mkdir -p $HOME/bin

# stuff I use
sudo apt install -y guake fish vim-gtk xclip jq curl nginx

# ruby dependencies
libssl-dev libreadline-dev zlib1g-dev

# other work packages
sudo apt install -y postgresql postgresql-contrib libpq-dev redis libxml2-dev

# screen recordings
if ! command -v peek &> /dev/null; then
  sudo add-apt-repository -y ppa:peek-developers/stable
  sudo apt update
  sudo apt install -y peek
fi

# ruby/node/yarn version management
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
  curl "https://downloads.slack-edge.com/releases/linux/4.29.149/prod/x64/slack-desktop-4.29.149-amd64.deb" -o slack.deb
  sudo apt install -y ./slack.deb
  rm slack.deb
fi

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

# PgAdmin
if ! test e /usr/pgadmin4; then
  curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
  sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
  sudo apt install -y pgadmin4-desktop
fi

# 1Password
if ! command -v 1password &> /dev/null; then
  sudo apt-key --keyring /usr/share/keyrings/1password.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
  sudo apt update && sudo apt install 1password
fi

# Heroku
if ! command -v heroku &> /dev/null; then
  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
fi

### CONFIGURE ENVIRONMENT

# postgres
sudo -u postgres createuser -s $(whoami)

