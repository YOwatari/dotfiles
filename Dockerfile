FROM ubuntu:20.04

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo \
      curl \
      make \
      git \
      build-essential \
      lsb-release \
      ca-certificates

RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

ARG HOST_UID=1001
ARG HOST_GID=1001
RUN (groupadd -g ${HOST_GID} dot || true) && \
    useradd --create-home --no-log-init -s /bin/bash -u ${HOST_UID} -g ${HOST_GID} dot && \
    echo "dot ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dot

RUN mkdir -p /home/dot/.local/share/chezmoi
COPY --chown=dot:dot ./ /home/dot/.local/share/chezmoi/

WORKDIR /home/dot/.local/share/chezmoi

CMD ["/bin/bash"]
