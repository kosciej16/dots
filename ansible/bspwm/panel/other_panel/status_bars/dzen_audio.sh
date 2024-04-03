#!/bin/bash

#=== Settings ===#
SLEEP=0.1

speaker_icon="^i($HOME/.config/bspwm/panel/icons/spkr_01.xbm)"
mute_icon="^i($HOME/.config/bspwm/panel/icons/spkr_mute.xbm)"
mpd_icon="^i($HOME/.config/bspwm/panel/icons/mpd.xbm)"

#=== Loop ===#
while :; do

# Current desktop
# curr_tag=$(bspc query -D -d)

# if [ $curr_tag == "1/i" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}|   "
# elif [ $curr_tag == "1/ii" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}|  "
# elif [ $curr_tag == "1/iii" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}| "
# elif [ $curr_tag == "1/iv" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}|  "
# elif [ $curr_tag == "1/v" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}|   "
# elif [ $curr_tag == "1/vi" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}|  "
# elif [ $curr_tag == "1/vii" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}| "
# elif [ $curr_tag == "1/viii" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}|"
# elif [ $curr_tag == "1/ix" ]
# then
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}|  "
# else
#     tag="${color_sec1}|${color_main}$curr_tag${color_sec1}|   "
# fi

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

echo "$volume $mpd"

sleep $SLEEP; done
