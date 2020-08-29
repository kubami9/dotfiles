#! /bin/bash

nitrogen --restore &
killall redshift &
xcompmgr &
redshift -l manual -l 51.126:17.033 -m vidmode &
xbindkeys --poll-rc &
setxkbmap -option caps:swapescape &
xset r rate 280 50 &
dunst &
~/Downloads/GG/gg &

function check_battery {
        IS_CHARGING=$(acpi | awk '{print $3}')
        BATTERY=$(acpi | awk '{print $4}' | sed 's/%,//g')
        if [ $IS_CHARGING = 'Discharging' ] && [ $BATTERY -lt 25]
        then
            notify-send -t 7000 "BATTERY" "Low battery percentage. Plug in the charger. Please :)"
        fi
}
function battery_info {
        echo "$(acpi | sed 's/ 0//') |"
}
while true; do
        check_battery
	xsetroot -name " $(battery_info) $( date +"%F %A %R" )"
   sleep 1m    # Update time every minute
done &
