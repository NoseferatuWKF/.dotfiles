# ALIAS

alias vim="nvim"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias ll="ls -l"
alias lr="ls -lr"
alias la="ls -lah"
alias lar="ls -lahr"
alias diff="diff --color=always"

# ENV

PATH=$PATH:~/scripts
PATH=$PATH:~/.cargo/bin
TERM=screen-256color

function ya() {
	local tmp="$(mktemp)"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
