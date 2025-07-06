#!/bin/sh

# Start sxhkd before bspwm
sxhkd &

# Start bspwm
exec bspwm
