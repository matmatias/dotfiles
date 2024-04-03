#!/bin/bash

PACKAGE_MANAGER="apt"
INSTALL_COMMAND="install"
UPDATE_COMMAND="update"

mv $HOME/.bashrc $HOME/.bashrc.bak
echo "INSTALLING PACKAGES..."
sudo $PACKAGE_MANAGER $UPDATE_COMMAND
sudo $PACKAGE_MANAGER $INSTALL_COMMAND -y git curl xclip tmux ripgrep wget unzip gzip fontconfig dialog apt-utils build-essential stow cmake gdb fonts-noto # devscripts debhelper fakeroot file gnupg lintian quilt dh_make

# Python dependencies
sudo $PACKAGE_MANAGER $INSTALL_COMMAND -y zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
echo "PACKAGES INSTALLED!"

# Docker Engine
DOCKER_ENV_PATH=/.dockerenv
if [ -f "$DOCKER_ENV_PATH" ]; then
  echo "SCRIPT IS BEING EXECUTED IN A CONTAINER, DOCKER WON'T BE INSTALLED"
else
  echo "SCRIPT IS BEING EXECUTED IN A REAL MACHINE, INSTALLING DOCKER..."
  sudo $PACKAGE_MANAGER $INSTALL_COMMAND -y ca-certificates gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo $PACKAGE_MANAGER $UPDATE_COMMAND
  sudo $PACKAGE_MANAGER $INSTALL_COMMAND -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  echo "DOCKER INSTALLED"
  echo "SETTING UP DOCKER"
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  echo "DOCKER SET"
fi

echo "INSTALLING CASKAYDIACOVE NERD FONT"
sudo wget -O /usr/share/fonts/cascadiacode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip
sudo mkdir /usr/share/fonts/cascadiacode && sudo unzip /usr/share/fonts/cascadiacode.zip -d /usr/share/fonts/cascadiacode
fc-cache -f -v
echo "FONT INSTALLED!"

echo "INSTALLING ASDF"
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.13.1
echo "ASDF INSTALLED!"

export PATH=$PATH:$HOME/.asdf/bin
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add python
asdf plugin-add asdf plugin-add java https://github.com/halcyon/asdf-java.git

echo "INSTALLING RUST STABLE"
asdf install rust stable
asdf global rust stable
echo "RUST INSTALLED!"

echo "INSTALLING PYTHON"
asdf install python 3.10.13
asdf global python 3.10.13
echo "PYTHON INSTALLED!"

echo "INSTALLING NODE v18.17.1"
asdf install nodejs 18.17.1
asdf global nodejs 18.17.1
echo "NODE INSTALLED!"

echo "INSTALLING JAVA"
asdf install java openjdk-22
asdf global java openjdk-22
echo "JAVA INSTALLED!"

echo "INSTALLING BOB (NVIM VERSION MANAGER)"
CARGO_PATH="$HOME/.asdf/shims"
"$CARGO_PATH/cargo" install bob-nvim
echo "BOB INSTALLED!"

echo "INSALLING NVIM STABLE"
BOB_PATH="$HOME/.asdf/installs/rust/stable/bin"
"$BOB_PATH/bob" install stable
"$BOB_PATH/bob" use stable
echo "NVIM INSTALLED!"

echo "SETTING NVIM AS GIT'S DEFAULT TEXT EDITOR"
git config --global core.editor "nvim"

directories=()

while IFS= read -r -d '' dir; do
  dir_name=$(basename "$dir")

  if [ "$dir_name" != "scripts" ] && [ "$dir_name" != ".git" ]; then
    directories+=("$dir_name")
  fi
done < <(find . -mindepth 1 -maxdepth 1 -type d -print0)

echo "SYMLINKING DOTFILES"
for dir in "${directories[@]}"; do
  sudo stow "$dir"
done

echo "SYMLINKING DONE"
echo "It's highly recommend to change the terminal to dark mode so the nvim colorscheme works properly"
echo "It's also recommended to restart your system so everything is setup correctly"
echo "If you're (or intend to be) a .deb package creator/maintainer, copy bash/.env.debian then change .env.debian's content with your data, then restart the terminal"
echo "If you're not, ignore this."
