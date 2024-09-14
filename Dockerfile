FROM alpine:latest AS base

WORKDIR /root

COPY lnm nvim yazi .

RUN apk add curl bash git zsh tmux neovim jq ripgrep fzf cargo build-base cmake

RUN sed -E "s/sh/zsh/" /etc/passwd > patch && mv patch /etc/passwd

RUN curl -s https://ohmyposh.dev/install.sh | bash -s
RUN curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

RUN git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm

RUN cargo install --locked yazi-fm git-delta

RUN rm -rf ./themes

CMD ["zsh", "-l"]
