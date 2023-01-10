#!/bin/bash

profile=$1

on_logout() {
  $HOME/.local/bin/firefox-sync $profile
  $HOME/.local/bin/ramdisk detach
  exit
}

$HOME/.local/bin/ramdisk 512
trap 'on_logout' SIGINT SIGHUP SIGTERM

while true; do
  $HOME/.local/bin/firefox-sync $profile
  sleep 1800 &
  wait $!
done
