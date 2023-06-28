#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{F#44475a}%{T20}%{T-}"
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
    echo "%{F#9C9C9C}%{T20}%{T-}"
  fi
  echo "%{F#8e24aa}%{T20}%{T-}"
fi

