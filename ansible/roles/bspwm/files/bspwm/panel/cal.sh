#!/bin/sh

  DZEN=dzen2
 title=dzen-calender
  fore="#ffffff"
  back="#303030"
highbg="#00BFFF"
highfg="#202020"
icons=$BITMAP_DIR/fn26
calex=$PANEL_DIR/cal.sh

# cur_col, next_col, icon
trans() {
	cur_col=$1
	next_col=$2
	icon=$3

	str=""
	str=$str"^fg($cur_col)^bg($next_col)"
	str=$str"^i($icon)"
	str=$str"^fg()^bg()"
	
	echo "$str"
}

if [ -z "$curx" ]; then
	curx=$(xdotool getmouselocation)
	curx=${curx%% *}
	curx=${curx##*:}
	export curx
fi

opts="m:y:"

args=$(getopt $opts $@ 2>/dev/null)
eval set -- "$args"
unset args

while true; do
	case $1 in
		("-m")
			month=$2
			shift 2
			continue
		;;
		("-y")
			year=$2
			shift 2
			continue
		;;
		("--") break ;;
	esac
done

month=${month:=$(date +%m)}
month=${month#0}

## Loop to years
if [ $month -lt 1 ]; then
       	month=12
       	year=$(($year - 1))
elif [ $month -gt 12 ]; then
       	month=1
	year=$(($year + 1))
fi

curdate="$(date +'%b %Y' -d $year-$month-1)"

calbody=$(cal $month $year | sed -e '/^ *$/d' -e '1d' -e 's/_\x08//g')

calhead="\
^ca(1, $calex -m $(( $month - 1 )) -y $year)\
$(trans "$highbg" $back $icons/tri/mid_right_tri_stripe.xbm)\
^ca()\
^fg($highfg)^bg($highbg) \
$curdate \
^ca(1, $calex -m $(( $month + 1 )) -y $year)\
$(trans $highbg $back $icons/tri/mid_left_tri_stripe.xbm)^bg($back)\
^ca()"

# highlight day (current month)
if [ $month -eq $(date +%m) ] && [ $year -eq $(date +%Y) ]; then
	day=$(date +%-d)
	calbody=$(echo "$calbody" | \
		sed "s/\(^\| \)$day\( \|$\)/\1^fg($highfg)^bg($highbg)$day^fg()^bg()\2/")
fi

calender="$calhead\n$calbody"
lines=$(($(echo "$calender" | wc -l) - 1))

pkill -f $title

echo "$calender" | 
	$DZEN -p \
	-fn "FreeMono" \
	-title-name "$title" -slave-name "$title" \
	-fg $fore -bg $back \
	-h 26 -w 214 \
	-x $(( $curx - 113 )) -y 28 \
	-ta c -sa c \
	-l $lines \
	-e "onstart=uncollapse;
	;button3=exit;
	;button4=exec:$calex -m $(( $month + 1 )) -y $year;
	;button5=exec:$calex -m $(( $month - 1 )) -y $year;"
