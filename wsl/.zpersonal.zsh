# ALIAS

alias vim="nvim"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias ll="ls -l"
alias lr="ls -lr"
alias la="ls -lah"
alias lar="ls -lahr"
alias nerd="sudo nerdctl"
alias diff="diff --color=always"

# ENV

PATH="$HOME/scripts:$HOME/.cargo/bin:$PATH"

# HASH

hash -d dotfiles=$HOME/.dotfiles
hash -d nvim=$HOME/.config/nvim
hash -d scripts=$HOME/scripts

# UTILS

generate_password() {
    local LENGTH="20"
    local CHAR="!-z"
    echo $(LC_ALL=C tr -dc $CHAR < /dev/urandom | head -c $LENGTH)
}

ya() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
