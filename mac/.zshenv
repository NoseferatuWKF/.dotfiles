export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/go
export PATH=/opt/homebrew/opt/ansible@2.9/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/Library/Frameworks/Python.framework/Versions/3.10/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:$GOPATH/bin
export LC_CTYPE=en_US.UTF-8
. "$HOME/.cargo/env"
eval "$(fnm env --use-on-cd)"
