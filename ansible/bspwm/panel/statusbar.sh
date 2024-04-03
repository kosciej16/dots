#!/bin/bash




date_mod="true"

. /home/kosciej/.config/bspwm/panel/vars
CALCMD=$PANEL_DIR/cal.sh
icons=$BITMAP_DIR/fn26
trans="$icons/tri/mid_right_tri_stripe_inv.xbm"

   fore='#ffffff'
  fore2='#000000'
   back='#303030'
   col1="#303030"
   col2="#505050"
   col3="#707070"
   col4="#44aabb"
   col5="#00BFFF"
   col6="#87CEFA"

transition() {
	prev_col=$1
	cur_col=$2

	bartxt=$bartxt"^fg($prev_col)^bg($cur_col)"
	bartxt=$bartxt"^i($trans)"
	bartxt=$bartxt"^fg($fore)"
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
    timetxt=$(date +"%H:%M:%S")
	bartxt="$bartxt $timetxt"
		# timetxt=$timetxt" ^fg($col6)"
		# timetxt=$timetxt"^ca(1, $TIMECMD)"
		# timetxt=$timetxt"^i($icons/fn26/hourglass2.xbm)"
		# timetxt=$timetxt"^ca()"
		# timetxt=$timetxt"^fg()"
}
speaker_icon="^i($BITMAP_DIR/fn26/vol_off.xbm)"
mute_icon="^i($HOME/.config/bspwm/panel/icons/spkr_mute.xbm)"
mpd_icon="^i($BITMAP_DIR/mpd.xbm)"

#=== Loop ===#
while :; do

# volume
    playback=$(amixer get Master | sed -rn '$s/[^[]+\[([0-9]+%).*/\1/p')
    is_off=$(amixer get Master | sed -rn '$s/[^[]+\[([0-9]+%).*/\1/p')

    if [ $playback == "0%" ]
    then
        playback_format="000%"
    elif [ $playback == "100%" ]
    then
        playback_format="${color_main}100%"
    else
        playback_format=$(printf "%04s" $playback | sed "s/ /0/g;s/\(^0\+\)/\1${color_main}/")
    fi

    volume="${color_sec1}${speaker_icon} ${color_sec2}${playback_format}"

    # mpd
    mpc_current=$(mpc current | sed 's/AnimeNfo Radio | Serving you the best Anime and Doujin music!: //')

    mpc_time=$(mpc | grep / | sed 's/\[playing\] #[0-9]*\/[0-9]*   //' | sed 's/\[paused\]  #[0-9]*\/[0-9]*   //')

    mpd="${color_sec1}${mpd_icon} ${color_main}${mpc_current} ${color_red}| ${color_main}${mpc_time}"

    echo " $volume $mpd"
    # echo "A"

    sleep 1
done > $LEFT_FIFO &
i=0
maxref=300
while true; do
	bartxt=""

    set_date
	# transition "$col2" "$col3"
    set_time
    # echo $bartxt > $RIGHT_FIFO
	
	## UPDATES
	# if [ $(( $i % 2 )) -eq 0 ]; then
	# 	time_mod="true"	
	# fi
	# if [ $(( $i % 10 )) -eq 0 ]; then
	# 	network_mod="true"	
	# fi
	# if [ $(( $i % 30 )) -eq 0 ]; then
	# 	vol_mod="true"
	# 	music_mod="true"
	# fi
	if [ $i -eq 0 ]; then
		date_mod="true"
	fi

	# transition "$back" "$col4"
	# set_name
	# transition "$col4" "$col2"
	# set_music
	# transition "$col2" "$col3"
	# set_vol
	# transition "$col3" "$col1"
	# set_network
	# transition "$col1" "$col2"
	# set_date
	# transition "$col2" "$col3"
	# set_time
	
	echo "$bartxt"

	## 0 <= i < maxref
	i=$(( ($i+1) % $maxref ))
	sleep 1

done > $RIGHT_FIFO &
