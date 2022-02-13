# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Produces "21 days", for example
uptime_formatted="up $(uptime | cut -d ',' -f1  | cut -d ' ' -f6)"

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01:32)
date_formatted=$(date "+%a %F %H:%M:%S")

# Get the Linux version but remove the "-1-ARCH" part
linux_version=$(uname -r | cut -d '-' -f1)

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# porn_folder=$(du -sh ~)

# Emojis and characters for the status bar
#     ⚡  \|
echo  $uptime_formatted ↑ linux v$linux_version '|' $date_formatted

