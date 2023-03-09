# alias
alias vim="nvim"

# UTILS
checkout() {
  git checkout $(git branch -a | fzf | xargs)
}


