# colors
case "${TERM}" in
    kterm*|xterm*)
	export LSCOLORS=exfxcxdxbxegedabagacad
	export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
	;;
    cons25)
	unset LANG
	export LSCOLORS=ExFxCxdxBxegedabagacad
	export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
	;;
esac

# locale
export LANG=ja_JP.UTF-8

# editor
export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient

# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
# enable shims and autocompletion
eval eval "$(pyenv init -)"

# enable auto-activation of virtualenvs
eval "$(pyenv virtualenv-init -)"

# Java
export PATH=$HOME/eclipse:$PATH

# Go
export PATH=/opt/go/bin:$PATH
export GOPATH=$HOME/.go

