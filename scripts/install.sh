#!/bin/bash

PACKAGE_MANAGER="apt"
INSTALL_COMMAND="install"

sudo apt update
echo "Installing packages..."
sudo $PACKAGE_MANAGER $INSTALL_COMMAND git curl stow xclip tmux
echo "Packages installed!"

echo "Installing asdf"
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.13.1
echo "asdf installed!"

echo "Installing rust stable"
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust stable
asdf global rust stable
echo "Rust installed!"

echo "Installing bob (nvim version manager)"
cargo install bob-nvim
echo "Bob installed!"

echo "Insalling nvim stable"
bob install stable
bob use stalbe
echo "Nvim installed!"

directories=()

while IFS= read -r -d '' dir; do
  dir_name=$(basename "$dir")

  if [ "$dir_name" != "scripts" ] && [ "$dir_name" != ".git" ]; then
    directories+=("$dir_name")
  fi
done < <(find . -mindepth 1 -maxdepth 1 -type d -print0)

echo "Symlinking dotfiles"
for dir in "${directories[@]}"; do
  stow "$dir"
done
echo "Symlinking done"
