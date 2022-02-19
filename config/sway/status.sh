# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.


# Returns the battery status: "Full", "Discharging", or "Charging".
volume=$(pamixer --get-volume-human)

battery_status=$(cat /sys/class/power_supply/BAT0/status)
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)

date_fmt=$(date --rfc-3339=seconds | cut -c 1-16)

internet_status=$(ping -c 1 1.1.1.1 -w 1 | grep '1 received' | wc -l)
if [ "$internet_status" == "0" ]; then
    internet_status_fmt="offline"
else
    internet_status_fmt="online"
fi


porn_folder=$(du -sh ~ | awk '{print $1}')

# Emojis and characters for the status bar
#     ⚡  \|
echo "www: $internet_status_fmt | ~: $porn_folder | BL: $(light)% | VOL: $volume | ⚡$battery_status $battery_capacity% | $date_fmt"

