MAX0="$(cat /sys/class/power_supply/BAT0/energy_full)"
MAX1="$(cat /sys/class/power_supply/BAT1/energy_full)"
CAP0="$(cat /sys/class/power_supply/BAT0/energy_now)"
CAP1="$(cat /sys/class/power_supply/BAT1/energy_now)"

BAT="$(echo "100*(${CAP0}+${CAP1})/(${MAX0}+${MAX1})" | bc)"

echo $BAT%
