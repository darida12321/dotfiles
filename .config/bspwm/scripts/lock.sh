#!/bin/sh

. "${HOME}/.cache/wal/colors.sh"

alpha='dd'
background="$background"
selection="$color0"
comment="$color8"

primary="$color4"
secondary="$color8"
red="$color1"
green="$color2"

i3lock \
  --insidever-color=$selection$alpha \
  --insidewrong-color=$selection$alpha \
  --inside-color=$selection$alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ring-color=$secondary$alpha \
  --line-uses-ring \
  --keyhl-color=$primary$alpha \
  --bshl-color=$red$alpha \
  --separator-color=$primary$alpha \
  --verif-color=$green \
  --wrong-color=$red \
  --layout-color=$secondary \
  --date-color=$secondary \
  --time-color=$secondary \
  --screen 1 \
  --blur 1 \
  --clock \
  --indicator \
  --time-str="%H:%M:%S" \
  --date-str="%A %e %B %Y" \
  --verif-text="Checking..." \
  --wrong-text="Wrong pswd" \
  --noinput="No Input" \
  --lock-text="Locking..." \
  --lockfailed="Lock Failed" \
  --radius=120 \
  --ring-width=10 \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-power-keys \
  --pass-volume-keys \
  --time-font="RobotoMonoNerdFont" \
  --date-font="RobotoMonoNerdFont" \
  --layout-font="RobotoMonoNerdFont" \
  --verif-font="RobotoMonoNerdFont" \
  --wrong-font="RobotoMonoNerdFont" \

