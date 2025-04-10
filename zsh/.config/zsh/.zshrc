#
# zshrc
#

# enable colors
#
autoload -U colors && colors

# history
#
HISTSIZE="1000000"
SAVEHIST="1000000"
HISTFILE="$HOME/.cache/history/zsh"

# completions
#
autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# aliases
#
alias ls="ls --color=auto -v --group-directories-first"
alias grep="grep --color=auto"

# shell addons
#
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
eval "$(starship init zsh)"
