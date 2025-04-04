#!/bin/bash

[ -p $MIDDLE_FIFO ] || mkfifo $MIDDLE_FIFO

export color_main="^fg(#cdc5b3)"
export color_black="^fg(#000000)"
export color_sec1="^fg(#72aca9)"
export color_red="^fg(#F21108)"

time_icon="^i($BITMAP_DIR/clock.xbm)"
TWCMD=/home/kosciej/.config/bspwm/panel/timew.sh

# trap 'update' 5

# update() { \
# 	   echo "| $(workspace)" &
# 	   wait
# }
# pkill -SIGTRAP bspwmws

set_time() {
    # summary=$(timew summary :day)
    # total_time=$(echo "$summary" | grep -Eo '[0-9]+:[0-9]+:[0-9]+' | tail -n 1)
    #
    total_time_hm=$(echo "$total_time" | cut -d ':' -f 1,2)
	# bartxt="$bartxt $total_time_hm"
    bartxt="$bartxt $($TWCMD)"
}

transition() {
    bartxt="$bartxt$SEP"
}

i=0
maxref=300
while :; do
	bartxt=""

# volume
    set_time
    # set_workspace
    # transition
    echo $bartxt
    sleep 60

done > $MIDDLE_FIFO
