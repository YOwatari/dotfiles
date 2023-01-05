FROM ubuntu:latest

RUN set -x \
    && apt-get update \
    && apt-get install -y sudo curl make git build-essential lsb-release

RUN set -x \
    && groupadd -g 1000 dot \
    && useradd -m -s /bin/bash -u 1000 -g 1000 dot \
    && echo "dot ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dot
COPY --chown=dot:dot ./ ./home/dot/dotfiles
WORKDIR /home/dot/dotfiles
