#!/bin/sh

## Runs recieving dzen instance for statusbar (listens on fifo)
#	- kills statusbar on exit

. /home/kosciej/.config/bspwm/panel/vars

# export color_main="^fg(#cdc5b3)"
# export color_sec1="^fg(#72aca9)"
# export color_sec2="^fg(#72aca9)"
# export color_red="^fg(#F21108)"

# export font="UbuntuMono-R-8"

# fg_color="#cdc5b3"
# bg_color="#0e0e0e"

# dzen_style="-fg $fg_color -bg $bg_color -fn $font -h 20"

# ~/.config/bspwm/panel/status_bars/dzen_main.sh      | dzen2  -y 0 -x -1 -w 100 -ta r $dzen_style &
# ~/.config/bspwm/panel/status_bars/dzen_main.sh      | dzen2  -y 10 -x 500 $dzen_style &
# ~/.config/bspwm/panel/status_bars/dzen_audio.sh     | dzen2 -y 0 -x 0    -w 700 -ta l $dzen_style &
# ~/.config/bspwm/panel/status_bars/dzen_title.sh     | dzen2 -y 0 -x 0    -w 700 -ta l $dzen_style &
fore='#ffffff'
back='#303030'
DZEN=/usr/local/bin/dzen2
left_title=dzen_left
right_title=dzen_right

pkill statusbar
pkill -f "title-name $left_title "
pkill -f "title-name $right_title "
$PANEL_DIR/left_statusbar.sh &
$PANEL_DIR/right_statusbar.sh &
sleep 1

$DZEN	-title-name "${left_title}" \
	-fn "Source Code Pro-11" \
	-fg "$fore" -bg "$back" \
	-x 5 -y 0 \
    -h 26 \
	-tw 960 \
	-ta l \
	-p < $LEFT_FIFO &
	# -e "button3=exit,exec:$sigbar SIGTERM;\
	# ;button2=exec:$sigbar" < $myfifo 

$DZEN	-title-name "${right_title}" \
	-fn "Source Code Pro-11" \
	-fg "$fore" -bg "$back" \
	-x 960 -y 0 \
    -h 26 \
	-tw 960 \
	-ta r \
	-p < $RIGHT_FIFO &
	# -e "button3=exit,exec:$sigbar SIGTERM;\
	# ;button2=exec:$sigbar" < $myfifo 


