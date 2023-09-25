###############
# Compinstall #
###############

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' ignore-parents parent .. directory
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/dani/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt nomatch menucomplete
unsetopt autocd beep extendedglob notify


#############
# Vim Setup #
#############

# Enable vim
bindkey -v
KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
	echo -ne '\e[1 q'

	elif [[ ${KEYMAP} == main ]] ||
	   [[ ${KEYMAP} == viins ]] ||
	   [[ ${KEYMAP} = '' ]] ||
	   [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
	echo -ne '\e[5 q'
}

################
# Key bindings #
################

bindkey "^?" backward-delete-char # Backspace
bindkey '^H' backward-kill-word   # Control + backspace
bindkey '^W' backward-delete-word # Control + w

bindkey "^[[3;5~" kill-word # Control + delete
bindkey "\e[3~" delete-char # Delete

bindkey "^[[1;5C" forward-word  # Control + right
bindkey "^[[1;5D" backward-word # Control + left

bindkey '^I' vi-forward-word # Tab
bindkey '^ ' expand-or-complete # Control + space

zmodload zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

###############
# Other setup #
###############

# Color
(cat ~/.cache/wal/sequences &)
eval "$(starship init zsh)"

# Aliases
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias vim=nvim
alias ls='exa --icons --all --across --group-directories-first'
alias ll='exa --icons --all --long'
alias tree='exa --icons --all --tree --level 3'

# Path
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

###########
# Plugins #
###########

# Zsh autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Zsh syntax highlighting
source ~/.config/zsh/zsh-syntax-highlighting-dracula.sh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Stop highlighting when pasting
zle_highlight=('paste:none')




