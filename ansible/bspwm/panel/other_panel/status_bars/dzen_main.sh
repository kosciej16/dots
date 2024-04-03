#!/bin/bash

# -------------------
# SETTINGS
# -------------------

SLEEP=1

fs_icon="^i($HOME/.config/bspwm/panel/icons/diskette.xbm)"

cpu_icon="^i($HOME/.config/bspwm/panel/icons/cpu.xbm)"
mem_icon="^i($HOME/.config/bspwm/panel/icons/mem.xbm)"
time_icon="^i($HOME/.config/bspwm/panel/icons/clock.xbm)"

battery_10_icon="^i($HOME/.config/bspwm/panel/icons/battery10.xbm)"
battery_50_icon="^i($HOME/.config/bspwm/panel/icons/battery50.xbm)"
battery_90_icon="^i($HOME/.config/bspwm/panel/icons/battery90.xbm)"

# -------------------
# FUNCTIONS
# -------------------
function wrapper {
    if [ $1 -eq 0 ]
    then
        echo "000"
    elif [ ${#1} -ge 3 ]
    then
        echo "${color_main}$1"
    else
        echo $(printf "%03d" $1 | sed "s/\(^0\+\)/\1${color_main}/")
    fi
}

#cpu
PREV_TOTAL=0
PREV_IDLE=0

# ----------------------
# LOOP
# ----------------------
while :; do

# disk
root_used=$(df /           | grep -Eo '[0-9]+%' | sed s/%//)
data_used=$(df /mnt/slack       | grep -Eo '[0-9]+%' | sed s/%//)
storage_used=$(df /tmp | grep -Eo '[0-9]+%' | sed s/%//)

root="${color_sec1}${fs_icon} /root ${color_sec2}$(wrapper $root_used)%"
home="${color_sec1}${fs_icon} /home ${color_sec2}$(wrapper $data_used)%"
tmp="${color_sec1}${fs_icon} /tmp ${color_sec2}$(wrapper $storage_used)%"


# cpu
CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
unset CPU[0]                          # Discard the "cpu" prefix.
IDLE=${CPU[4]}                        # Get the idle CPU time.

# Calculate the total CPU time.
TOTAL=0
for VALUE in "${CPU[@]}"; do
  let "TOTAL=$TOTAL+$VALUE"
done

# Calculate the CPU usage since we last checked.
let "DIFF_IDLE=$IDLE-$PREV_IDLE"
let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

# Remember the total and idle CPU times for the next check.
PREV_TOTAL="$TOTAL"
PREV_IDLE="$IDLE"

cpu="${color_sec1}${cpu_icon} ${color_sec2}$(wrapper ${DIFF_USAGE})%"

# memory
# memory_total=$(free -m | awk 'FNR == 2 {print $2}')
# memory_used=$(free -m | awk 'FNR == 3 {print $3}')
# memory_free_percent=$[$memory_used * 100 / $memory_total]
# mem="${color_sec1}${mem_icon} ${color_sec2}$(wrapper ${memory_free_percent})%"

# time
tim=$(date +"%a %d-%m-%y %T")
time="${color_red}| ${color_sec1}${time_icon} ${color_main}$tim"

# battery

battery=$(acpi | sed "s/Battery 0: //g" | sed "s/[ ,a-zA-Z]//g" | sed "s/[0-9][0-9]://g" | sed "s/%[0-9][0-9]//g" | sed "s/%//g")

if [[ $battery == 100 ]]
then
    bat=$(echo $color_sec1 ${battery_90_icon} $color_main$battery%)
elif [[ $battery > 60 ]]
then
    bat=$(echo $color_sec1 ${battery_90_icon} $color_main$battery%)
elif [[ $battery > 30 ]]
then
    bat=$(echo $color_sec1 ${battery_50_icon} $color_main$battery%)
elif [[ $battery < 30 ]]
then
    bat=$(echo $color_sec1 ${battery_10_icon} $color_red$battery%)
fi

echo "$wm_status $bat $cpu $time"

sleep $SLEEP; done
