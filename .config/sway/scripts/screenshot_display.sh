#!/bin/bash

output_id=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')
grim -o $output_id - | satty --filename - --output-filename ~/Pictures/Screenshots/Screenshot_$(date '+%Y%m%d-%H:%M:%S').png
