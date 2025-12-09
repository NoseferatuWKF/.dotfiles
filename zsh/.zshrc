# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt histignorealldups

# do not include failed commands in history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
zshaddhistory

# keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# antibody
[[ ! -f ~/.zsh_plugins.sh ]] && antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh 
source ~/.zsh_plugins.sh

[[ ! -f ~/.zpersonal.zsh ]] || source ~/.zpersonal.zsh
[[ ! -f ~/.secrets.env ]] || source ~/.secrets.env

[ ! command -v nvim &> /dev/null ] || export EDITOR=nvim

# oh-my-posh
eval "$(oh-my-posh init zsh --config ~/peru.omp.json)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
