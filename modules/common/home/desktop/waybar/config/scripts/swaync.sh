#!/usr/bin/env bash

swaync-client --inhibitor-add xdg-desktop-portal-hyprland
swaync-client -t -sw 
swaync-client --inhibitor-remove xdg-desktop-portal-hyprland
