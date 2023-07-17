# Basic configs
cat /home/dani/.cache/wal/sequences # Colors

# Aliases
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Enable vim mode
fish_vi_key_bindings

# Set up shortcuts
bind -M insert \cF forward-char
bind -M insert : forward-word
