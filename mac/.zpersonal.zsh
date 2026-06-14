#!/bin/zsh

# ALIAS

alias vim="nvim"
alias ls="ls --color=auto -G"
alias ll="ls -l"
alias lr="ls -lr"
alias la="ls -lah"
alias lar="ls -lahr"
alias grep="grep --color=auto"

# ENV

PATH="${HOME}/scripts:${PATH}"
GOPATH=$HOME/go
PATH="${PATH}:${GOPATH}/bin"
XDG_CONFIG_HOME=$HOME/.config
LC_CTYPE=en_US.UTF-8

# HASH

hash -d athena=$HOME/athena 
hash -d dotfiles=$HOME/.dotfiles
hash -d nvim=$HOME/.config/nvim

# NPM

npm_test() {
  echo "What files to watch?"
  read files
  tmux splitw -v bash -c "find src | grep $files | entr -cr npm run test $files"
}

# KUBECTL

kubectl_exec() {
  echo "What namespace?"
  read namespace
  tmux splitw -v "kubectl exec -it -n $namespace $(kubectl get pods -n $namespace --no-headers -o custom-columns=":metadata.name" | fzf) -- ash" # maybe sh is better
}

kubectl_logs() {
  echo "What namespace?"
  read namespace
  tmux splitw -v "kubectl logs -n $namespace $(kubectl get pods -n $namespace --no-headers -o custom-columns=":metadata.name" | fzf) | less"
}

kubectl_context() {
  kubectl config use-context $(kubectl config get-contexts | grep -v NAME | fzf  | awk '{print $1}')
}

kubectl_search() {
  echo "What namespace?"
  read namespace
  tmux splitw -v "kubectl get all -n $namespace | fzf"
}

generate_password() {
    local LENGTH="20"
    local CHAR="0-9a-zA-Z"
    export LC_ALL=C
    echo $(tr -dc $CHAR < /dev/urandom | head -c $LENGTH)
    unset LC_ALL
}

ya() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

psl() {
    local cmd=$1
    # [[ $cmd == serve ]] && _goportal_serve $project
    # [[ $cmd == debug ]] && _goportal_debug $project
    # [[ $cmd == test ]] && _goportal_test $2
    [[ $cmd == compose ]] && finch compose -f ~/projects/persol/apac-obm/grafana/docker-compose.yml --env-file ~/projects/persol/apac-obm/grafana/.env ${@:2}
    # [[ $cmd == make ]] && make -sC ~/projects/persol/make ${@:2}
}

# _goportal_serve() {
#     tmux neww dotnet watch -c Release -nr:false --environment Local --project $1
#     tmux split -h npm run --prefix ~/projects/psk/goportal/src/GoPortal/Webpack build:watch
#     # tmux split python -m http.server -d ~/projects/persol/scalar/
# }
#
# _goportal_debug() {
#     tmux neww -c $1/bin/Debug/net8.0 \
#     "DOTNET_URLS=\"https://localhost:7188;http://localhost:5153\" \\
#     ASPNETCORE_ENVIRONMENT=Development dotnet GoPortal.dll --environment Local"
# }
#
# _goportal_test() {
#     local target="GoPortal.UnitTest.WebAPI"
#     [[ $1 ]] && target=$1
#     dotnet test -c Release ~/projects/psk/goportal/src/GoPortalSolution.sln -property:WarningLevel=0 --filter DisplayName~$target
# }
