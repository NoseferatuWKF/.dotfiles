# ALIAS

alias vim="nvim"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias ll="ls -l"
alias lr="ls -lr"
alias la="ls -lah"
alias lar="ls -lahr"
alias nerd="sudo nerdctl"
alias xsc="xclip -selection c"
alias diff="diff --color=always"

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
61346566333035356434666566623434396231363865373330646636376330313834623464343833
3266343034333263633663346462313736626338316130380a383132386332363531343461353362
66663366653462323139343038386461396235306538656365626232386430313164323165333864
6165653032666466310a373965366636333037616432393434653233646565306338656439333933
65613066633032373632363931363336303332323063626239303632663065323533
EOF
)

STEAM=$(cat << EOF
\$ANSIBLE_VAULT;1.1;AES256
35613266393036396431306530353265663534646135333265373433383263383536313962386633
3935323138346164623764623730636536366333346131320a366633643133303764643838346163
33653830343464353534303866366336346361366236616530346263373637343061316335656138
6331333134646630630a316464626536313730643565656230663665626162383435303566666236
34643938393938656639656533356365316439613835326562336533316333353866
EOF
)

PROXMOX=$(cat << EOF
\$ANSIBLE_VAULT;1.1;AES256
38623237666530636362616365613765306137343131666164626336326634373562306538346662
3538336532313137313730346363636136383039383032660a646130336134643666656535653965
62616231666232323338636662643566633164666364636463373535346437666466643161323137
3631356133356163310a623532353962353531636162656135333736306131376638396338623135
61656632613633613733396164316339666464306539346634646162336437383939
EOF
)

ROUTER=$(cat << EOF
\$ANSIBLE_VAULT;1.1;AES256
37373836383139333832353430326461663031396631613266663438333335316461383731376264
6662303564363865313334323865346633653664303232330a363863613031363331316666663036
39313237666331363239656433393930373761316237613765346531323464336263643931646439
3731646666326431610a343130653636326639653363396562346365323934383539646535353662
36333164633964343266613263376463653638663237643430323263333432316537
EOF
)

# HASH

hash -d athena=$HOME/athena 
hash -d dotfiles=$HOME/.dotfiles
hash -d nvim=$HOME/.config/nvim
hash -d wallpapers=$HOME/wallpapers
hash -d scripts=$HOME/scripts

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

create_password() {
  local LENGTH="21"
  local CHAR="!-z"
  echo $(LC_ALL=C tr -dc $CHAR < /dev/urandom | head -c $LENGTH)
}
