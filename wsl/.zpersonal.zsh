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

PATH="$HOME/scripts:$HOME/.cargo/bin:$HOME/.dotnet/tools:$PATH"
eval "$(fnm env --use-on-cd --shell zsh)"

# HASH

hash -d dotfiles=$HOME/.dotfiles
hash -d nvim=$HOME/.config/nvim
hash -d scripts=$HOME/scripts
hash -d athena=/mnt/c/Users/WANF886/athena

# UTILS

generate_password() {
    local LENGTH="20"
    local CHAR="0-9a-zA-Z"
    LC_ALL=C echo $(tr -dc $CHAR < /dev/urandom | head -c $LENGTH)
}

ya() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

goportal() {
    local project=~/projects/psk/goportal/src/GoPortal
    local cmd=$1
    [[ $cmd == serve ]] && _goportal_serve $project
    [[ $cmd == debug ]] && _goportal_debug $project
    [[ $cmd == test ]] && _goportal_test $2
    [[ $cmd == compose ]] && nerd compose -f ~/projects/utils/compose/docker-compose.yml --env-file ~/projects/utils/compose/.env ${@:2}
    [[ $cmd == make ]] && make -sC ~/projects/utils/make ${@:2}
}

_goportal_serve() {
    tmux neww dotnet watch -c Release -nr:false --environment Local --project $1
    tmux split -h npm run --prefix ~/projects/psk/goportal/src/GoPortal/Webpack build:watch
    # tmux split python -m http.server -d ~/projects/utils/scalar/
}

_goportal_debug() {
    tmux neww -c $1/bin/Debug/net8.0 \
    "DOTNET_URLS=\"https://localhost:7188;http://localhost:5153\" \\
    ASPNETCORE_ENVIRONMENT=Development dotnet GoPortal.dll --environment Local"
}

_goportal_test() {
    local target="GoPortal.UnitTest.WebAPI"
    [[ $1 ]] && target=$1
    dotnet test -c Release ~/projects/psk/goportal/src/GoPortalSolution.sln -property:WarningLevel=0 --filter DisplayName~$target
}
