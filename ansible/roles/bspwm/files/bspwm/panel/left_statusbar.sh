#!/bin/bash

[ -p $LEFT_FIFO ] || mkfifo $LEFT_FIFO

export color_main="^fg(#cdc5b3)"
export color_black="^fg(#000000)"
export color_sec1="^fg(#72aca9)"
export color_red="^fg(#F21108)"

speaker_icon="^i($BITMAP_DIR/spkr_01.xbm)"
bt_icon="^i($BITMAP_DIR/bt.xbm)"
mute_icon="^i($HOME/.config/bspwm/panel/icons/spkr_mute.xbm)"
mpd_icon="^i($BITMAP_DIR/mpd.xbm)"
play_icon="^i($BITMAP_DIR/play.xbm)"


# trap 'update' 5

# update() { \
# 	   echo "| $(workspace)" &
# 	   wait
# }
# pkill -SIGTRAP bspwmws

get_active_sink() {
    # Look for sinks that have a "State: Running" status, and get their names
    pactl list sinks | awk '/State: RUNNING/,/Name:/' | grep 'Name:' | awk '{print $2}'
}

set_volume() {
    sink_name=$(get_active_sink)

    [[ $sink_name == bluez* ]] && icon="${bt_icon}" || icon=${speaker_icon}

    # playback=$(amixer get Master | sed -rn '$s/[^[]+\[([0-9]+%).*/\1/p')
    playback=$(pactl list sinks | grep -A 15 "Name: $sink_name" | grep 'Volume:' | head -n1 | awk '{print $5}')
    is_muted=$(pactl list sinks | grep -A 15 "Name: $sink_name" | grep 'Mute:' | awk '{print $2}')


    # is_off=$(amixer get Master | grep off)
    [[ $is_muted == "yes" ]] && color="$color_black" || color=$color_sec1

    volume="${color}${icon} ${color_main}${playback}"
	bartxt="$bartxt $volume"

}
    
set_mpd() {
    mpc_current=$(mpc current | sed 's/AnimeNfo Radio | Serving you the best Anime and Doujin music!: //')
    mpc_time=$(mpc | grep / | sed 's/\[playing\] #[0-9]*\/[0-9]*   //' | sed 's/\[paused\]  #[0-9]*\/[0-9]*   //')
    mpd="${color_sec1}${mpd_icon} ${color_main}${mpc_current} | ${color_main}${mpc_time} ${play_icon}"

	bartxt="$bartxt $mpd"
}

set_music() {
    track=$(spotifycli --song)
    artist=$(spotifycli --artist)
    # controll="^fn(Noto Color Emoji)^ca(1, playerctl play-pause)⏯^ca() ^ca(1, playerctl next)⏭^ca()^fn()"
    music="${color_sec1}${mpd_icon} ${color_main}$artist - $track $controll"
	bartxt="$bartxt $font $music"
}

set_workspace() {
    WS=$(bspc wm -g |
        sed -Ee 's/:m/ \n  M\>/g' \
        -e 's/:O|:F/ \n ^fg(#E2D134)/g' \
        -e 's/:o/ \n ^fg(#717171)/g' \
        -e 's/:U/ \n ^fg(#F2D134)/g' \
        -e 's/:u/ \n ^fg(#932727)/g' \
        -e 's/:/ \n  /g' \
        | grep "fg" \
        | sed 's/Desktop/S/g' \
        | tr '\n' '@' \
        | sed 's/@/^fg()\|/g')

	bartxt="$bartxt $WS"
}

transition() {
    bartxt="$bartxt$SEP"
}

i=0
maxref=300
while :; do
	bartxt=""

# volume
    set_volume
    transition
    # set_music
    # transition
    # set_workspace
    # transition
    echo $bartxt
    sleep 1

done > $LEFT_FIFO
