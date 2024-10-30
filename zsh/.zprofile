#
# zprofile
#

# config files
#
export ZDOTDIR="$HOME/.config/zsh"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npmrc"
export WGETRC="$HOME/.config/wgetrc"

# history files
#
export MYSQL_HISTFILE="$HOME/.cache/history/mariadb"
export REDISCLI_HISTFILE="$HOME/.cache/history/valkey"
export LESSHISTFILE="$HOME/.cache/history/less"

# misc
#
export PF_INFO="ascii title os wm shell kernel pkgs memory"

# start hyprland
#
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec Hyprland
fi