#!/bin/bash

PACKAGE_MANAGER="apt"
INSTALL_COMMAND="install"
UPDATE_COMMAND="update"

mv $HOME/.bashrc $HOME/.bashrc.bak
echo "INSTALLING PACKAGES..."
sudo $PACKAGE_MANAGER $UPDATE_COMMAND
sudo $PACKAGE_MANAGER $INSTALL_COMMAND -y git curl xclip tmux ripgrep wget unzip gzip dialog apt-utils build-essential stow
echo "PACKAGES INSTALLED!"

echo "INSTALLING CASKAYDIACOVE NERD FONT"
sudo wget -O /usr/share/fonts/cascadiacode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip
mkdir /usr/share/fonts/cascadiacode && unzip /usr/share/fonts/cascadiacode.zip -d /usr/share/fonts/cascadiacode
fc-cache -f -v
echo "FONT INSTALLED!"

echo "INSTALLING ASDF"
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.13.1
echo "ASDF INSTALLED!"

echo "INSTALLING RUST STABLE"
ASDF_PATH="$HOME/.asdf/bin"
"$ASDF_PATH/asdf" plugin-add rust https://github.com/code-lever/asdf-rust.git
"$ASDF_PATH/asdf" install rust stable
"$ASDF_PATH/asdf" global rust stable
echo "RUST INSTALLED!"

echo "INSTALLING BOB (NVIM VERSION MANAGER)"
CARGO_PATH="$HOME/.asdf/shims"
"$CARGO_PATH/cargo" install bob-nvim
echo "BOB INSTALLED!"

echo "INSALLING NVIM STABLE"
BOB_PATH="$HOME/.asdf/installs/rust/stable/bin"
"$BOB_PATH/bob" install stable
"$BOB_PATH/bob" use stable
echo "NVIM INSTALLED!"

directories=()

while IFS= read -r -d '' dir; do
  dir_name=$(basename "$dir")

  if [ "$dir_name" != "scripts" ] && [ "$dir_name" != ".git" ]; then
    directories+=("$dir_name")
  fi
done < <(find . -mindepth 1 -maxdepth 1 -type d -print0)

echo "SYMLINKING DOTFILES"
for dir in "${directories[@]}"; do
  stow "$dir"
done
echo "SYMLINKING DONE"
