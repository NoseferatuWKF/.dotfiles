# UTILS
checkout() {
  git checkout $(git branch -a | fzf | xargs)
}


