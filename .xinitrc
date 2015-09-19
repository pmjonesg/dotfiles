#!/bin/sh

# Remap caps to esc
setxkbmap -option caps:escape
xrdb -merge .Xresources

# i3
exec i3
