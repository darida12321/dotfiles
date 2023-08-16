#!/bin/sh

connection_list=$(nmcli -t -f name,type,device,state connection show --order name --active 2>/dev/null | grep -v ':bridge:')
has_ethernet=0
has_wifi=0
wifi_signal=0

while read -r line; do
type=$(echo "$line" | sed -e 's/\\:/-/g' | cut -d ':' -f 2)
device=$(echo "$line" | sed -e 's/\\:/-/g' | cut -d ':' -f 3)

if [ "$type" = "802-11-wireless" ]; then
    has_wifi=$((1))

    signal=$(nmcli -t -f in-use,signal device wifi list ifname "$device" | grep "\*" | cut -d ':' -f 2)
    if [ "$signal" -gt "$wifi_signal" ]; then
	wifi_signal=$signal
    fi
elif [ "$type" = "802-3-ethernet" ]; then
    has_ethernet=1
fi
done < <(echo "$connection_list")


echo -n "%{A1:nm-connection-editor:}%{A3:nm-connection-editor:}"
if [ "$has_ethernet" -eq 1 ]; then
    echo -n "󱎔"
elif [ "$has_wifi" -eq 1 ]; then
if [ "$wifi_signal" -lt 20 ]; then
    echo -n "󰤯"
elif [ "$wifi_signal" -lt 40 ]; then
    echo -n "󰤟"
elif [ "$wifi_signal" -lt 60 ]; then
    echo -n "󰤢"
elif [ "$wifi_signal" -lt 80 ]; then
    echo -n "󰤥"
else
    echo -n "󰤨"
fi
else
    echo -n "󰤮"
fi
echo "%{O-3} %{A}%{A}%{O-3} "



