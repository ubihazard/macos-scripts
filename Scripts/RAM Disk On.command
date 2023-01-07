#!/bin/bash

function text_dialog()
{
  local result=$(osascript << EOT
    set response to display dialog "How many megabytes?"\
      default answer "512" with icon note buttons {"Cancel", "Continue"}\
      default button "Continue"
    return text returned of response
  EOT)

  echo "$result"
}

sizemb=$(text_dialog)
if [ "$sizemb" == "" ] || [ -n ${sizemb//[0-9]/} ] || [ $sizemb -lt 32 ]; then
  echo "Invalid size: \"$sizemb\". Enter valid size in MBs."
  exit 1
fi

ramdisk $sizemb
