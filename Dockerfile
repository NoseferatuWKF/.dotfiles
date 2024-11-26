FROM alpine:latest AS base

WORKDIR /root

COPY zsh/.zshrc zsh/peru.omp.json zsh/.zsh_plugins.txt .
COPY lnm .
COPY tmux .
COPY git .
COPY nvim .
COPY yazi .

RUN apk add curl bash git zsh tmux neovim jq ripgrep fzf cargo build-base cmake

RUN sed -E "s/sh/zsh/" /etc/passwd > patch && mv patch /etc/passwd
RUN curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /bin
RUN curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

RUN git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm

RUN cargo install --locked yazi-fm@0.2.3 
RUN cargo install --locked git-delta

RUN rm -rf ./themes

CMD ["zsh", "-l"]
