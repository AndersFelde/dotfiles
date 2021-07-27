#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap no
killall bgchd
mons --primary DP-2
mons -e right 
bgchd -dir /home/kippster/Pictures/Wallpaper/ -intv 15m -bcknd feh &
guake &
picom --config /home/kippster/.config/picom/picom.conf &
xautolock -time 5 -locker "/usr/bin/i3lock-solarized-dark.sh" -killtime 20 -killer "systemctl suspend" -detectsleep &
setxkbmap -option caps:escape &
/usr/bin/dunst &
batsignal -w 20 -c 15 -d 10 -W "Charge maybe?" -C "Should charge" -D "/usr/bin/xbacklight -set 10" -I "/usr/share/icons/Papirus-Dark/16x16/devices/battery.svg" &
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on' #for burpsuite blant annet

# rclone mount "OneDrive": /home/kippster/skole/OneDrive --vfs-cache-mode writes --cache-dir /home/kippster/.cache/rclone --log-level INFO --log-file /home/kippster/.log/rclone.log &
exec i3
