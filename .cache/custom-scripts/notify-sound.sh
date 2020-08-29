#!/bin/bash

notify-send -t 200 "Volume" "$(amixer get Master | grep 'Left' | grep '[][]' | awk '{print $5,$6}')"
