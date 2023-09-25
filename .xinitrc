#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Set up zshrc
export ZDOTDIR=$HOME/.config/zsh

# Execute programs
setxkbmap -layout gb,hu -option grp:alt_shift_toggle & # Keyboard
picom -fb &                           # Compositor
nitrogen --restore &                  # Wallpaper
wal -R &                              # Color scheme
~/.config/polybar/launch.sh &         # Taskbar
xsetroot -cursor_name left_ptr &      # Cursor
pgrep -x sxhkd > /dev/null || sxhkd & # Shortcuts
xbanish &			      # Hide cursor when typing
exec bspwm                            # Window manager








