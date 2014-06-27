#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xrdb -merge .Xresources
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
xrandr --output DVI-D-1 --auto --output HDMI-1 --auto --rotate left --right-of DVI-D-1 &
mount-tray &
#tint2 &
#exec openbox-session 
exec i3

#
