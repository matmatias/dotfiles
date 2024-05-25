#!/bin/bash

PACKAGE_MANAGER="apt"
INSTALL_COMMAND="install"
UPDATE_COMMAND="update"

echo "INSTALLING PACKAGES..."
sudo $PACKAGE_MANAGER $UPDATE_COMMAND
sudo $PACKAGE_MANAGER $INSTALL_COMMAND -y git curl xclip tmux ripgrep wget unzip gzip dialog apt-utils build-essential stow cmake gdb fonts-noto nodejs openjdk-17-jdk

# Python dependencies
sudo $PACKAGE_MANAGER $INSTALL_COMMAND -y zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
echo "PACKAGES INSTALLED!"

echo "INSTALLING RUST"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "INSTALLING BOB (NVIM VERSION MANAGER)"
$HOME/.cargo/bin/cargo install bob-nvim --version 2.7.0
echo "BOB INSTALLED!"

echo "INSALLING NVIM STABLE"
$HOME/.cargo/bin/bob install stable
$HOME/.cargo/bin/bob use stable
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

echo "INSTALLATION DONE, HAPPY HACKING"
