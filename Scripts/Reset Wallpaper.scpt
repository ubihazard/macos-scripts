-- Save as an applet that stays open and add to user's login items:
-- `osacompile -x -s -o 'Reset Wallpaper.app' 'Reset Wallpaper.scpt'`
--
-- Hide app from Dock (Info.plist):
--   <key>LSUIElement</key>
--   <string>1</string>

on run
  -- Do nothing
end run

on idle
  -- Do nothing
end idle

on quit
  set osVer to system version of (system info)
  considering numeric strings
    set isHighSierra to osVer >= "10.13" and osVer < "10.14"
    set isSierra to osVer >= "10.12" and osVer < "10.13"
  end considering
  if isHighSierra is true
    tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/High Sierra.jpg"
  else if isSierra is true
    tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/Sierra.jpg"
  end if
end quit
