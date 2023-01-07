#!/bin/bash

function confirm_dialog()
{
  local result=$(osascript 2>/dev/null << EOT
    set response to display dialog "Reset Launchpad?"\
      with icon caution buttons {"Cancel", "Continue"}\
      default button "Cancel"\
      cancel button "Cancel"
    return button returned of response
  EOT)

  echo "$result"
}

if [ "$(confirm_dialog)" == "Continue" ]; then
  rm -f ~/Library/Application\ Support/Dock/*.db*
  defaults write com.apple.dock ResetLaunchPad -bool true
  killall Dock
fi
