#!/bin/bash

[ -p $RIGHT_FIFO ] || mkfifo $RIGHT_FIFO

date_mod="true"
internet_mod="true"

CALCMD=/home/kosciej/.config/bspwm/panel/cal.sh
icons=$BITMAP_DIR/fn26

set_date() {
	datetxt=""

	if [ "$date_mod" = "true" ]; then
		datetxt=$datetxt"^ca(1, $CALCMD -m $(date +%m) -y $(date +%Y))"
		datetxt=$datetxt"$(date +' %a - %d/%m/%y')"
		datetxt=$datetxt"^ca()"
	else
		datetxt=$datetxt"$date_prev"
	fi

	date_mod="false"
	date_prev=$datetxt

	bartxt=$bartxt"$datetxt"
}


set_internet() {
	if [ "$internet_mod" = "true" ]; then
        ping -q -w 1 -c 1 8.8.8.8 > /dev/null && color=$COLOR_DEFAULT || color=$COLOR_RED
        ip=`ip -f inet addr show wlp0s20f3 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p'`
        [ -z $ip ] || ip="($ip)"
        ssid=`iwgetid -r | cut -d" " -f1`
        ip="$ssid^fg($color) $ip^fg()"
    else
		ip=$ip_prev
    fi
    ip_prev=$ip
    internet_mod="false" 
	bartxt="$bartxt$ip"

}


set_power() {
    battery=$(acpi | sed "s/Battery 0: //g" | sed "s/[ ,a-zA-Z]//g" | sed "s/[0-9][0-9]://g" | sed "s/%[0-9][0-9]//g" | sed "s/%//g")

    if [[ $battery > 60 || $battery == 100 ]]
    then
        icon="^i($BITMAP_DIR/battery90.xbm)"
    elif [[ $battery > 30 ]]
    then
        icon="^i($BITMAP_DIR/battery50.xbm)"
    elif [[ $battery < 30 ]]
    then
        icon="^i($BITMAP_DIR/battery10.xbm)"
    fi
    charging=$(acpi | grep Discharging)
    [[ $charging ]] && color="$COLOR_RED" || color=$COLOR_GREEN
    powertxt="$icon ^fg($color)$battery%^fg()"
	bartxt="$bartxt$powertxt"

}

set_time() {
    timetxt=$(date +"%H:%M:%S")
	bartxt="$bartxt $timetxt"
		# timetxt=$timetxt" ^fg($col6)"
		# timetxt=$timetxt"^ca(1, $TIMECMD)"
		# timetxt=$timetxt"^i($icons/fn26/hourglass2.xbm)"
		# timetxt=$timetxt"^ca()"
		# timetxt=$timetxt"^fg()"
}

transition() {
    bartxt="$bartxt$SEP"
}

i=0
maxref=300
while true; do
	bartxt=""

    set_internet
    transition
    set_power
    transition
    set_date
    transition
    set_time
    echo $bartxt
	
	if [ $i -eq 0 ]; then
		date_mod="true"
	fi

	if [ $(( $i % 10 )) -eq 0 ]; then
		internet_mod="true"
	fi

	i=$(( ($i+1) % $maxref ))
	sleep 1

done > $RIGHT_FIFO
