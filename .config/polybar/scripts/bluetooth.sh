#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then 
  echo "%{F#6272A4}%{T20}%{T-}" # border
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
    echo "%{F#F8F8F2}%{T20}%{T-}" # foreground
  fi
  echo "%{F#BD93F9}%{T20}%{T-}" # primary
fi

