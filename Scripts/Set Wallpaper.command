#!/bin/bash

function file_dialog()
{
  local result=$(osascript << EOT
    set dpath to POSIX file "$HOME/Pictures/"
    tell application "Finder"
      activate
      set fpath to POSIX path of (\
        choose file of type {"BMP", "PNG", "JPG", "JPEG"}\
          default location dpath\
      )
      return fpath
    end tell
  EOT)

  echo "$result"
}

wall=$(file_dialog)
[ ! -f "$wall" ] && exit 1
wallpaper "$wall"
