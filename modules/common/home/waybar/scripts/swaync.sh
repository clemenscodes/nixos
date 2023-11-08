#!/usr/bin/env bash

swaync-client --inhibitor-add xdg-desktop-portal-wlr >/dev/null 2>&1
swaync-client -t -sw 
swaync-client --inhibitor-remove xdg-desktop-portal-wlr >/dev/null 2>&1
