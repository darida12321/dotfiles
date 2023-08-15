#!/bin/sh

source "${HOME}/.cache/wal/colors.sh"

bluetooth_print() {
    bluetoothctl | while read -r REPLY; do
    	echo -n "%{F"

        if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -gt 0 ]; then

            devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
            counter=0

            for device in $devices_paired; do
                device_info=$(bluetoothctl info "$device")

                if echo "$device_info" | grep -q "Connected: yes"; then
                    counter=$((counter + 1))
                fi
            done


	    if [ $counter -gt 0 ]; then
	        echo -n "$color4" # Primary color
	    else
	        echo -n "$foreground" # White color
	    fi

        else
            echo -n "$color8" # Border color
        fi

	echo "}%{T20}${T-}"
    done
}

bluetooth_toggle() {
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac
