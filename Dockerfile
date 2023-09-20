FROM debian:bookworm

RUN apt update && apt install -y sudo
RUN useradd -m user && passwd -d user
RUN usermod -aG sudo user

RUN rm /home/user/.bashrc
COPY . /home/user/.dotfiles 
RUN chmod 755 /home/user/.dotfiles/scripts/install.sh

WORKDIR /home/user
USER user

CMD tail -f /dev/null
