#!/bin/zsh

# PATH should be placed in .zshenv
# EDITOR should be placed in .zprofile

# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# Create a folder and move into it in one command
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'
alias g='git'
alias s='git status'
alias gdiff='git diff'
alias gres='git restore'
alias gswc='git switch'
