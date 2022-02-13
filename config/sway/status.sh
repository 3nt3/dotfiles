# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.


# Returns the battery status: "Full", "Discharging", or "Charging".
volume=$(pamixer --get-volume-human)

battery_status=$(cat /sys/class/power_supply/BAT0/status)
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)

date_fmt=$(date --rfc-3339=seconds | cut -c 1-19)

# porn_folder=$(du -sh ~)

# Emojis and characters for the status bar
#     ⚡  \|
echo "BL: $(light)% | VOL: $volume | ⚡$battery_status $battery_capacity% | $date_fmt"

