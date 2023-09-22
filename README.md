# Dotfiles
  This is my dotfiles configuration. Currently works on debian based distros only!

## Features
  - .bashrc
  - asdf
  - nvim
  - install.sh: this script installs and setup bash, cmake, gcc, asdf, rust, bob (nvim version manager), nvim and all the dependencies needed to make everything work out of the box.

## Setup
  To set everything up, run:
  ```bash
  git clone git@github.com:MatMatias/dotfiles $HOME/.dotfiles
  cd $HOME/.dotfiles
  sudo chmod 755 ./scripts/install.sh
  ./scripts/install.sh
  ```
  Then restart your bash session.

### Neovim
  To setup neovim, run:
  ```bash
  nvim
  ```
  Wait for all plugins to be installed, then quit it. Now it is configured and ready for use.
  
  To check neovim's configuration, check nvim/.config/nvim.

## Test scripts
To test scripts, you can build a docker container from the Dockerfile image present in the root directory of the repository.

To build it, run:
```bash
docker build -t fresh_debian .
```
Then use the new fresh debian to test the scripts:
```bash
docker run -d --name fresh_debian -d fresh_debian
sudo docker exec -it fresh_debian /bin/bash
```

## Help
If you have any problems using this, feel free to open a issue and/or reach me out.
