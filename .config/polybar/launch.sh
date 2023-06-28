#!/usr/bin/env bash

# Terminate already running bars
killall -q polybar

# Launch bar
echo "---" >> /tmp/polybar.log
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars launched..."
