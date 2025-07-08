#!/bin/bash

current=$(setxkbmap -query | awk '/layout/ {print $2}')
if [ "$current" = "us" ]; then
    setxkbmap -layout ir
else
    setxkbmap -layout us
fi
