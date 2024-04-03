#!/bin/sh

## Runs recieving dzen instance for statusbar (listens on fifo)
#	- kills statusbar on exit

fore='#ffffff'
back='#303030'
myfifo=/tmp/rightstat.fifo
DZEN=/usr/local/bin/dzen2
title=dzenrightstatus
# sigbar=$HOME/usr/share/dzen/bar/sigrightbar.sh

pkill -f "title-name $title "
pkill right_statusbar
(pgrep -f "right_statusbar.sh" >/dev/null || $PANEL_DIR/right_statusbar.sh &)
sleep 1

$DZEN	-title-name "$title" \
	-fn "Source Code Pro-11" \
	-fg "$fore" -bg "$back" \
	-x -960 -y 0 \
    -h 26 \
	-tw 960 \
	-ta r \
	-p < $myfifo
	# -e "button3=exit,exec:$sigbar SIGTERM;\
	# ;button2=exec:$sigbar" < $myfifo 

