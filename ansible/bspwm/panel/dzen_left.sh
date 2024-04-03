#!/bin/sh

## Runs recieving dzen instance for statusbar (listens on fifo)
#	- kills statusbar on exit

fore='#ffffff'
back='#303030'
myfifo=/tmp/leftstat.fifo
DZEN=/usr/local/bin/dzen2
title=dzenleftstatus
# sigbar=$HOME/usr/share/dzen/bar/sigleftbar.sh

pkill -f "title-name $title "
pkill left_statusbar
(pgrep -f "left_statusbar.sh" >/dev/null || $PANEL_DIR/left_statusbar.sh &)
sleep 1

$DZEN	-title-name "$title" \
	-fn "Source Code Pro-11" \
	-fg "$fore" -bg "$back" \
	-x 0 -y 0 \
    -h 26 \
	-tw 960 \
	-ta l \
	-p < $myfifo
	# -e "button3=exit,exec:$sigbar SIGTERM;\
	# ;button2=exec:$sigbar" < $myfifo 

