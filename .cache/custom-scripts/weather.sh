#!/bin/bash
if [ $# -gt 1 ]
then
    PLACES=$(echo $@ | sed 's/ /,/g')
    curl -s "wttr.in/{$PLACES}?format=3"
else
    curl wttr.in/$1
fi
