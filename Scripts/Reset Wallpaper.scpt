-- Save as an applet that stays open and add to user's login items:
-- `osacompile -x -s -o 'Reset Wallpaper.app' 'Reset Wallpaper.scpt'`
--
-- Hide app from dock (Info.plist):
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
    set isSonoma to osVer >= "14" and osVer < "15"
    set isVentura to osVer >= "13" and osVer < "14"
    set isMonterey to osVer >= "12" and osVer < "13"
    set isBigSur to osVer >= "11" and osVer < "12"
    set isCatalina to osVer >= "10.15" and osVer < "11"
    set isMojave to osVer >= "10.14" and osVer < "10.15"
    set isHighSierra to osVer >= "10.13" and osVer < "10.14"
    set isSierra to osVer >= "10.12" and osVer < "10.13"
  end considering

  set wallPath to ""
  if isSonoma is true then
    set wallPath to "/System/Library/Desktop Pictures/Sonoma Graphic.heic"
  else if isVentura is true then
    set wallPath to "/System/Library/Desktop Pictures/Ventura Graphic.heic"
  else if isMonterey is true then
    set wallPath to "/System/Library/Desktop Pictures/Monterey Graphic.heic"
  else if isBigSur is true then
    set wallPath to "/System/Library/Desktop Pictures/Big Sur Graphic.heic"
  else if isCatalina is true then
    set wallPath to "/System/Library/Desktop Pictures/Catalina.heic"
  else if isMojave is true then
    set wallPath to "/Library/Desktop Pictures/Mojave.heic"
  else if isHighSierra is true then
    set wallPath to "/Library/Desktop Pictures/High Sierra.jpg"
  else if isSierra is true then
    set wallPath to "/Library/Desktop Pictures/Sierra.jpg"
  end if

  if wallPath is not equal to ""
    tell application "Finder" to set desktop picture to POSIX file wallPath
  end if
end quit
