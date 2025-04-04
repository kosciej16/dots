#!/bin/bash

#=== Settings ===#
SLEEP=0.1

speaker_icon="^i($HOME/.config/bspwm/panel/icons/spkr_01.xbm)"
mpd_icon="^i($HOME/.config/bspwm/panel/icons/mpd.xbm)"

#=== Loop ===#
while :; do

# window title
title=$(xtitle)
if [[ $title != "" ]]
then
titl="${color_main}$title ${color_sec1}|"
else
titl="DUPA"
fi

echo "$tag $titl"

sleep $SLEEP; done
