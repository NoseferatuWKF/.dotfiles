#!/bin/zsh

# ALIAS

alias vim="nvim"
alias ls="ls --color=auto -G"
alias ll="ls -l"
alias lr="ls -lr"
alias la="ls -lah"
alias lar="ls -lahr"
alias nerd="sudo nerdctl"
alias grep="grep --color=auto"
alias terraform="nerd run --rm -it --name terraform -v $PWD:/terraform hashicorp/terraform -chdir=/terraform"

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
