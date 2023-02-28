# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac

export EDITOR="vim"
export MAKEFLAGS="-j$(getconf _NPROCESSORS_ONLN)"

export PATH="$PATH:$HOME/.local/bin"

# Borg
if test -e "/run/media"; then
    export BORG_REPO="/run/media/$USER/BasicBackups/borg"
elif test -e "/media"; then
    export BORG_REPO="/media/$USER/BasicBackups/borg"
fi

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Go
export GOPATH="$HOME/src/go"
export PATH="$PATH:$GOPATH/bin"

# KubeVirt
export KUBEVIRT_CRI=docker
export KUBEVIRTCI_RUNTIME=docker

# kubectl
if which kubectl >/dev/null 2>&1; then
    . <(kubectl completion bash)
    alias k=kubectl
    complete -F __start_kubectl k
fi

# krew
export PATH="$PATH:$HOME/.krew/bin"

# minikube
if which minikube >/dev/null 2>&1; then
    . <(minikube completion bash)
fi

# CRC
export PATH="$PATH:$HOME/.crc/bin"

# devscripts
export DEBFULLNAME="Andrea Bolognani"
export DEBEMAIL="eof@kiyuko.org"

# prompt

# colors
#   host     \033[38;5;207m
#   path     \033[38;5;117m
#   branch   \033[38;5;172m
#   other    \033[38;5;250m
#   default  \033[39m
# title      \033]0;...\007

# escape sequences must be enclosed by \[...\] (when added to PS1
# directly) or \001...\002 (when part of a function whose output is
# used in PS1 via command substitution)

__PS1_git_branch_name() {
    git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null
}

__PS1_git_color() {
    local branch_name=$(__PS1_git_branch_name)
    if test "$branch_name"; then
        # Note that we have to use \0002 instead of \002 right before
        # the name of the branch, because it could start with a digit
        # and that would in turn cause echo to output the wrong escape
        # sequence, as octals are allowed to have 1 to 3 digits after
        # the initial 0
        echo -e '\001\033[38;5;250m\002:\001\033[38;5;172m\0002'"$branch_name"
    fi
}

__PS1_git_nocolor() {
    local branch_name=$(__PS1_git_branch_name)
    if test "$branch_name"; then
        echo ":$branch_name"
    fi
}

case "$TERM" in
    *xterm*color)
        export PS1='\[\033]0;\h:\w\007\]\[\033[38;5;207m\]\h\[\033[38;5;250m\]:\[\033[38;5;117m\]\w$(__PS1_git_color)\[\033[38;5;250m\]\$\[\033[39m\] '
    ;;
    *)
        export PS1='\h:\w$(__PS1_git_nocolor)\$ '
    ;;
esac

# completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias vi="vim"
alias ls="ls --color=auto"

set -o vi
