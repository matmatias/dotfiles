# Dotfiles
  This is my dotfiles configuration. Currently works on debian based distros only!

## Features
  - .bashrc
  - asdf
  - nvim
  - install.sh: this script installs and setup bash, cmake, gcc, gdb, asdf, rust, python, nodejs, bob (nvim version manager), nvim, chromium, docker and all the dependencies needed to make everything work out of the box.

## Setup
  If you are (or intend to be) a debian package maintainer/creator, then run:
  ```bash
  cp bash/.env.debian.example bash/.env.debian
  ```
  Now change the .env.debian file with your data. If you are not a debian package maintainer/creator, you can ignore the step above.

  To set everything up, run:
  ```bash
  git clone git@github.com:MatMatias/dotfiles $HOME/.dotfiles
  cd $HOME/.dotfiles
  sudo chmod 755 ./scripts/install.sh && sudo chown $USER ./nvim
  ./scripts/install.sh
  ```
  Then restart your bash session.

### WSL
  If you're using WSL, run:
  ```bash
  ./scripts/wsl_install.sh
  ```
  Instead of
  ```bash
  ./scripts/install.sh
  ```
  The difference is that the wsl install script does not install chromium neither it tries to configure gnome

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
docker run -d --name fresh_debian -d fresh_debian && docker exec -it fresh_debian /bin/bash
```

Inside the container, to execute the install script, run:
```bash
cd .dotfiles && ./scripts/install.sh
```

To stop the container, run:
```bash
docker stop fresh_debian
```

To delete the container, run:
```bash
docker rm fresh_debian
```

## Help
If you have any problems using this, feel free to open a issue and/or reach me out.
