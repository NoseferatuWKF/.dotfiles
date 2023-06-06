# ALIAS

alias vim="nvim"
alias ll="ls -l"
alias lr="ls -lr"
alias la="ls -lah"
alias lar="ls -lahr"
alias nerd="sudo nerdctl"
alias xsc="xclip -selection c"

# ENV

PATH="${HOME}/scripts:${PATH}"

# SECRETS
EMAIL=$(cat << EOF
\$ANSIBLE_VAULT;1.1;AES256
61663033303632373833393239346138366661343038386539346437323139306162343462343931
3162623230333861353636626633333962356334373362300a323335393930633163653263663564
38353430373339343765643761326534336239346331353330366266373535383063373763666232
3663653661303061630a393339646530336539326331636361663263623762323039306462396466
32613966636138323436626163633033363162326239333232363635333436633165
EOF
)

M2U=$(cat << EOF
\$ANSIBLE_VAULT;1.1;AES256
66326561633532363463613831613762633635353163373665626466393061363262636664306366
3039613439613264626236316264303862633534343738320a633238333466306434643232306539
61633630303630656535303230636262626431333733623231376435373966353136653139323861
3634323831376661650a636136363931373063366638353436656637343136626335383231373464
62326438303236383735316331643439616538346237383762626163646538646530
EOF
)

# HASH

hash -d ansible=$HOME/ansible
hash -d athena=$HOME/athena 
hash -d dotfiles=$HOME/.dotfiles
hash -d nvim=$HOME/.config/nvim
hash -d wallpapers=$HOME/wallpapers

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
