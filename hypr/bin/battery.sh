percent=$(cat /sys/class/power_supply/BAT1/capacity)
status=$(cat /sys/class/power_supply/BAT1/status)


if [[ "$status" = "Charging" ]]; then
  icon="󱐋"
  color="#33cc33"
elif [[ "$status" = "Not charging" || "$status" = "Full" ]]; then
  icon=""
  color="#ffffff"
else
  if [[ "$percent" -lt 30 ]]; then
    icon=""
    color='#ff3333'
  elif [[ "$percent" -gt 70 ]]; then
    icon=""
    color='#33cc33'
  else
    icon=""
    color="#dddddd"
  fi
fi

echo "<span foreground='$color'>$percent% $icon</span>"
