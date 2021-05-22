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
    export BORG_REPO="/run/media/$USER/StoreJetBackups/borg"
elif test -e "/media"; then
    export BORG_REPO="/media/$USER/StoreJetBackups/borg"
fi

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Go
export GOPATH="$HOME/src/go"
export PATH="$PATH:$GOPATH/bin"

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

# Google Cloud SDK
if test -d ~/.google-cloud-sdk; then
    . ~/.google-cloud-sdk/path.bash.inc
    . ~/.google-cloud-sdk/completion.bash.inc
fi

# Android SDK
SDK="$HOME/tmp/android/sdk"
STUDIO="$HOME/tmp/android/studio"
export PATH="$PATH:$SDK/tools:$SDK/platform-tools:$STUDIO/bin"

# devscripts
export DEBFULLNAME="Andrea Bolognani"
export DEBEMAIL="eof@kiyuko.org"

. ~/.promptline.sh

alias vi="vim"
alias ls="ls --color=auto"

set -o vi
