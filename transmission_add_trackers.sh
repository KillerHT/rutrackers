#!/bin/bash
wget -O transmission_trackers.txt https://raw.githubusercontent.com/KillerHT/rutrackers/main/rutrackers_list.txt

while read -r tracker; do
    if [[ -n "$tracker" ]]; then
    #change transmission port DEFAULT: 9091
        transmission-remote 127.0.0.1:8080 -l | head -n -1 | awk 'NR>1 {print $1}' | while read -r id; do
            transmission-remote 127.0.0.1:8080 -t "$id" --tracker-add "$tracker" 2>/dev/null | grep -q "success" && echo "$id: success added $tracker"
        done
    fi
done < transmission_trackers.txt
