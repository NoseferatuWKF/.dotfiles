# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt histignorealldups

# do not include fail commands in history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

zshaddhistory

# keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# antibody
[[ ! -f ~/.zsh_plugins.sh ]] && antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh 
source ~/.zsh_plugins.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ ! -f ~/.zpersonal ]] || source ~/.zpersonal
