#!/usr/bin/env bash
set -e
BAT=/sys/class/power_supply/BAT0/charge_types
CONF=/etc/tlp.d/10-battery.conf

[[ $EUID -ne 0 ]] && exec sudo "$0" "$@"

if grep -q '\[Long_Life\]' $BAT; then new=0; else new=1; fi

printf 'START_CHARGE_THRESH_BAT0=0\nSTOP_CHARGE_THRESH_BAT0=%s\n' $new > $CONF
tlp start >/dev/null

if [[ $new == 1 ]]; then echo "Battery limit: ON"; else echo "Battery limit: OFF"; fi
echo "Proof: $(cat $BAT)"
