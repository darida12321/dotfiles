#!/bin/sh
# arg1: active color
# arg2: passive color

# Recolor border
# arg 1: Event string
# arg 2: Desktop arg num
recolor () {
	DESKTOP=$(echo "$1" | awk -v var="$2" '{print $var}')
	NUM=$(bspc query -N -d $DESKTOP -n .leaf | wc -l)

	if [ $NUM -eq 1 ] 
	then
		bspc config focused_border_color $4
	else
		bspc config focused_border_color $3
	fi
}



bspc subscribe node_focus | while read -r E; do recolor "$E" 3 $1 $2; done




