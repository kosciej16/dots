#!/bin/sh

## creates text to send to recieving dzen instance via fifo
#	- kills dzen instance on exit
#	- only updates modules on given intervals +on given signal

trap 'exit' INT TERM QUIT
trap 'pkill -f "title-name $title "' EXIT
trap "network_mod=true" RTMIN
trap "vol_mod=true" RTMIN+1
trap "music_mod=true" RTMIN+2
trap "network_mod=true; \
	vol_mod=true; \
	music_mod=true;" USR1

 col_on=green
col_off=grey
   fore='#ffffff'
  fore2='#000000'
   back='#303030'
   col1="#303030"
   col2="#505050"
   col3="#707070"
   col4="#44aabb"
   col5="#00BFFF"
   col6="#87CEFA"

title=dzenrightstatus

  DZENHOME=/home/kosciej/.config/bspwm/panel/other_panel
    NETCMD=$DZENHOME/internet.sh
    CALCMD=$DZENHOME/cal.sh
  MUSICCMD= #$DZENHOME/music.sh
    VOLCMD=$DZENHOME/vol.sh
   TIMECMD=$DZENHOME/timezone.sh
   RECDZEN=$DZENHOME/bar/dzenrightstatus.sh
SIGRIGHTBAR=$DZENHOME/bar/sigrightbar.sh
    DZEN=/usr/local/bin/dzen2
    MOCP="/usr/bin/mocp --moc-dir $HOME/.config/moc"

   icons=$DZENHOME/icons
dzenfifo=/tmp/rightstat.fifo
   trans=$DZENHOME/transright

   date_mod="true"
network_mod="true"
    vol_mod="true"
   time_mod="true"
  music_mod="true"

## HELPERS
# prev_col, cur_col (left <- right)
transition() {
	prev_col=$1
	cur_col=$2

	bartxt=$bartxt"^fg($prev_col)^bg($cur_col)"
	bartxt=$bartxt"^i($trans)"
	bartxt=$bartxt"^fg($fore)"
}
have_network() {
	PINGSERVER=opendns.com
	ping -q -c 1 -W 5 $PINGSERVER >/dev/null 2>/dev/null
	return
}

## MODULES
set_name() {
	[ -z "$name" ] && name=$(whoami)
	bartxt=$bartxt" $name "
}

set_network() {
	nettxt=""

	if [ "$network_mod" = "true" ]; then # Check connection

		if have_network; then
			ipcol=$col_on
			ipv4=$(ip address show wlan0 | \
				awk '/inet[^6]/{sub(/\/.*$/, "", $2); print $2}')
		else
			ipcol=$col_off
			ipv4="0.0.0.0"
		fi
		nettxt=$nettxt"^fg($ipcol) "
		nettxt=$nettxt"^ca(1, $NETCMD && sleep 1 && $SIGRIGHTBAR internet)"
		nettxt=$nettxt"^fn(FreeMono-12) $ipv4 ^fn()"
		nettxt=$nettxt"^ca()"
		nettxt=$nettxt"^fg()"
	else # SKIP
		nettxt="$network_prev"
	fi

	#echo "$nettxt" >&2

	network_mod="false"
	network_prev="$nettxt"

	bartxt=$bartxt"$nettxt"
}

set_date() {
	datetxt=""

	if [ "$date_mod" = "true" ]; then
		datetxt=$datetxt"^ca(1, $CALCMD -m $(date +%m) -y $(date +%Y))"
		datetxt=$datetxt"^fg($col5)"
		datetxt=$datetxt" ^i($icons/cal.xbm)"
		datetxt=$datetxt"^fg()"
		datetxt=$datetxt"^ca()"
		datetxt=$datetxt"$(date +' %a - %m/%d/%y')"
	else
		datetxt=$datetxt"$date_prev"
	fi

	date_mod="false"
	date_prev=$datetxt

	bartxt=$bartxt"$datetxt"
}

set_time() {
	timetxt=""
	if [ "$time_mod" = "true" ]; then
		timetxt=$timetxt" ^fg($col6)"
		timetxt=$timetxt"^ca(1, $TIMECMD)"
		timetxt=$timetxt"^i($icons/hourglass2.xbm)"
		timetxt=$timetxt"^ca()"
		timetxt=$timetxt"^fg()"
		timetxt=$timetxt"$(date +' %Z %I:%M:%S %p ')"
	else
		timetxt=$timetxt"$time_prev"
	fi
	time_mod="false"
	time_prev="$timetxt"

	bartxt=$bartxt"$timetxt"
}

set_vol() {
	voltxt=""

	if [ "$vol_mod" = "true" ]; then
		volstat=$(amixer get 'Master' | \
			awk '/Front (Left|Right):/{ printf "%s %s ", $5, $6 }' | \
		       	sed -e 's/\[//g' -e 's/%*\]//g')

		leftvol=$(echo $volstat | cut -d " " -f 1)
		rightvol=$(echo $volstat | cut -d " " -f 3)

		# Balance right to = left
		if [ "$leftvol" != "$rightvol" ]; then
			amixer set Master "$rightvol"%
			leftvol=$rightvol
		fi


		voltxt=$voltxt"^ca(4, amixer set Master unmute 2%+ >/dev/null && $SIGRIGHTBAR 35)"
		voltxt=$voltxt"^ca(5, amixer set Master unmute 2%- >/dev/null && $SIGRIGHTBAR 35)"
		if [ $(echo $volstat | cut -d " " -f 2) = "off" ] || [ $leftvol = "0" ] ; then
			vol_col=$col_off
			vol_ico=vol_off.xbm
		else
			vol_col=black
			vol_ico=vol_on.xbm
		fi	
		voltxt=$voltxt"^ca(1, $VOLCMD)"
		voltxt=$voltxt"^fg($vol_col)"
		voltxt=$voltxt" ^i($icons/$vol_ico)"
		voltxt=$voltxt"^fg()"
		voltxt=$voltxt"^ca()"
		voltxt=$voltxt"^ca(1, amixer set Master toggle >/dev/null && $SIGRIGHTBAR 35)"
		voltxt=$voltxt" $leftvol%"
		voltxt=$voltxt"^ca()"
		voltxt=$voltxt"^ca()"
		voltxt=$voltxt"^ca()"
	else
		voltxt=$voltxt"$vol_prev"
	fi
	
	vol_mod="false"
	vol_prev="$voltxt"

	bartxt=$bartxt"$voltxt"
}

set_music() {
	musictxt=""

	if [ "$music_mod" = "true" ]; then
		musstat=$($MOCP -Q '%state' 2>/dev/null)

		musictxt=$musictxt"^fg(#00ced1)"
		musictxt=$musictxt"^ca(1, $MUSICCMD)"
		musictxt=$musictxt" ^i($icons/music/music_note.xbm)"
		musictxt=$musictxt"^ca()"
		musictxt=$musictxt"^fg()"

		if [ -n "$musstat" ] && [ "$musstat" != "STOP" ]; then
			musictxt=$musictxt"^ca(1, $MOCP -r 2>/dev/null && $SIGRIGHTBAR 36)"
			musictxt=$musictxt" ^i($icons/music/back.xbm)"
			musictxt=$musictxt"^ca()"
			
			case $musstat in
				("PAUSE") musbtn=play.xbm ;;
				("PLAY") musbtn=pause.xbm ;;
			esac

			musictxt=$musictxt"^ca(1, $MOCP -G 2>/dev/null && $SIGRIGHTBAR 36)"
			musictxt=$musictxt"^i($icons/music/$musbtn)"
			musictxt=$musictxt"^ca()"
			musictxt=$musictxt"^ca(1, $MOCP -f 2>/dev/null && $SIGRIGHTBAR 36)"
			musictxt=$musictxt"^i($icons/music/forward.xbm)"
			musictxt=$musictxt"^ca()"
		fi
	else
		musictxt=$musictxt"$music_prev"
	fi
	
	music_mod="false"
	music_prev="$musictxt"

	bartxt=$bartxt"$musictxt"
}
set_terminal() {
	terminaltxt=""
	
}

pkill -f "dzen2 -title-name $title "

[ -p $dzenfifo ] || mkfifo $dzenfifo
$RECDZEN &

i=0
maxref=300
while true; do
	bartxt=""
	
	## UPDATES
	if [ $(( $i % 2 )) -eq 0 ]; then
		time_mod="true"	
	fi
	if [ $(( $i % 10 )) -eq 0 ]; then
		network_mod="true"	
	fi
	if [ $(( $i % 30 )) -eq 0 ]; then
		vol_mod="true"
		music_mod="true"
	fi
	if [ $i -eq 0 ]; then
		date_mod="true"
	fi

	## Modules
	#whoami
	transition "$back" "$col4"
	set_name
	transition "$col4" "$col2"
	# music
	set_music
	transition "$col2" "$col3"
	# volume
	set_vol
	transition "$col3" "$col1"
	# network
	set_network
	transition "$col1" "$col2"
	# date
	set_date
	transition "$col2" "$col3"
	# time
	set_time
	
	echo "$bartxt"

	## 0 <= i < maxref
	i=$(( ($i+1) % $maxref ))
	sleep 1

done > $dzenfifo
