#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# multiple monitors
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    export MONITOR=$m
    polybar main -c $HOME/.config/polybar/config.ini &

     
  done
else
    polybar main -c $HOME/.config/polybar/config.ini
fi

#Launch polybar
