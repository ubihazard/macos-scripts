# macOS tricks & tweaks

## General

After fresh install, you might want to apply the following.

### Prevent .DS_Store creation

```bash
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
#defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
```

This doesn’t seem to work for external drives (nor it have ever worked in older macOS versions). Use [alternative file manager](https://ranger.github.io/ "ranger") instead of Finder to prevent `.DS_Store` literring everywhere.

### Disable Time Machine prompts

```bash
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
```

### Enable always-expanded save dialogs

```bash
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
```

### Enable sub-pixel anti-aliasing for non-retina displays

(Mojave, Catalina, and Big Sur only.)

Apple has disabled sub-pixel font anti-aliasing starting with Mojave while dropping support for the last non-retina iMac and MacBook models. When using macOS with regular pixel density display, it can be re-enabled with:

```bash
defaults write -g CGFontRenderingFontSmoothingDisabled -bool false
```

Alternatively, you can leave sub-pixel AA disabled and control the strength of regular font smoothing instead (grayscale anti-aliasing):

```bash
defaults write -g AppleFontSmoothing -int $value # 0..3
```

The best `$value` depends on your particular display pixel density and resolution.

Note that these two settings are mutually exclusive and shouldn’t be used together. Also note that since Monterey neither setting can be changed because the ability to configure font anti-aliasing has been removed from the OS, along with sub-pixel AA itself, which had been gone already in Big Sur. (`AppleFontSmoothing` can still be adjusted in Big Sur.)

### Enable HiDPI resolutions for non-retina displays

```bash
sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true
```

Log out and back in for the change to take effect. Unfortunately, this doesn’t enable all resolutions that are technically possible. To unlock all resolutions a third-party app like **SwitchResX** is needed.

## Power

### Change the sleep timeout

Big Sur seemingly removed ability to set the timeout when machine goes to sleep independently from the display sleep timeout. It can still be configured using command line (in minutes):

```bash
sudo pmset -a sleep 15
```

### Turn hibernation off

```bash
sudo pmset -a hibernatemode 0
```

Now you can also remove the sleep image (preserves RAM contents during sleep), freeing up some space on your SSD, which can be precious on some lower end Macs:

```bash
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```

If you are on a hackintosh, turning hibernation off is necessary because “deep” sleep is not really supported on hacks.

## Security

### Restore the ability to set short passwords

You have to change the password policy.

```bash
pwpolicy getaccountpolicies > policies.plist
nano policies.plist
```

Remove the first line:

```
Getting global account policies
```

So that the file begins with:

```xml
<?xml version="1.0" encoding="UTF-8"?>
```

Find the password length requirement setting at:

```xml
      <key>policyContent</key>
      <string>policyAttributePassword matches '^$|.{4,}+'</string>
```

Change the match pattern from:

```regex
'^$|.{4,}+'
```

To:

```regex
'^$|.{1,}+'
```

Apply the new password policy:

```bash
pwpolicy setaccountpolicies policies.plist
rm policies.plist
```

You can now change your password to a shorter one in `System Preferences -> Users & Groups` as you would do before.

### Disable Gatekeeper

Before Catalina 10.5.6:

```
sudo spctl --master-disable
```

Catalina 10.5.6 and later:

```
sudo spctl --global-disable
```

Replace `disable` with `enable` to restore Gatekeeper.

## Finder

### Clear Finder Go to “Folder...” history

```bash
defaults delete com.apple.finder GoToField
defaults delete com.apple.finder GoToFieldHistory
```

### Allow Finder to quit

```bash
defaults write com.apple.finder QuitMenuItem -bool true
```

## System

### Rebuild kernel cache

Up until Big Sur rebuilding of the kernel kext cache could be done with:

```bash
sudo kextcache -i / && sudo kextcache -u /
```

On Catalina the root volume [has to be mounted in write mode](#mount-root-volume-as-writable).

See [below](#rebuild-kernel-cache-big-sur-and-later) how to rebuild kext cache in Big Sur.

### Mount root volume as writable

In Catalina the root volume is mounted read-only. Before any changes could be made to it, you need to re-mount it as writable:

```bash
sudo mount -uw /
```

### Root patching

Big Sur makes the process even more ~annoying~ involving. The root volume is “snapshotted” and you need to perform the following commands to modify the `/System`:

```bash
mkdir -p ~/.local/root
sudo mount -o nobrowse -t apfs /dev/diskXsY ~/.local/root
echo your changes here...
sudo bless --folder ~/.local/root/System/Library/CoreServices --bootefi --create-snapshot
sudo umount ~/.local/root
rmdir ~/.local/root
```

`diskXsY` can be obtained from `diskutil list`.

### Rebuild kernel cache (Big Sur and later)

Rebuilding kernel cache is also different since Big Sur. Run the following command before `bless`ing and creating a snapshot if you’ve made changes to the system’s kernel extensions:

```bash
sudo kmutil install --force --update-all --volume-root ~/.local/root
```

This step is supposed to be done during [root patching](#root-patching).

## Spotlight

Erase and rebuild index on volume:

```bash
sudo mdutil -E /Volumes/Data
```

Disable indexing of volume:

```bash
sudo mdutil -i off /Volumes/Data
```

Disable Spotlight on all volumes:

```bash
sudo mdutil -a -E && sudo mdutil -a -i off
```

## Airport

Control Airport from terminal:

```bash
ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport ~/.local/bin/airport
rehash
airport
```

## Version control

Disable version control for specific apps:

```bash
defaults write -app 'Sketch' ApplePersistence -bool no
defaults write -app 'Pixelmator' ApplePersistence -bool no
defaults write -app 'Pixelmator Pro' ApplePersistence -bool no
```

## Tasks

### Create .icns icon from .iconset

Starting from a 1024×1024 icon.png:

```bash
mkdir icon.iconset
sips -z 512 512 icon.png --out icon.iconset/icon_512x512.png
sips -z 256 256 icon.png --out icon.iconset/icon_256x256.png
sips -z 128 128 icon.png --out icon.iconset/icon_128x128.png
sips -z 64 64   icon.png --out icon.iconset/icon_32x32@2x.png
sips -z 32 32   icon.png --out icon.iconset/icon_32x32.png
sips -z 16 16   icon.png --out icon.iconset/icon_16x16.png
cp icon.iconset/icon_512x512.png icon.iconset/icon_256x256@2x.png
cp icon.iconset/icon_256x256.png icon.iconset/icon_128x128@2x.png
cp icon.iconset/icon_32x32.png icon.iconset/icon_16x16@2x.png
mv icon.png icon.iconset/icon_512x512@2x.png
iconutil -c icns icon.iconset
```

### Eject disc from tray via terminal

```bash
drutil tray eject

# If it’s stuck:
hdiutil detach -force "/Volumes/DVD Volume Name"
```

### Restore disc eject menu bar icon

```bash
open "/System/Library/CoreServices/Menu Extras/Eject.menu"
```

# ⭐ Support

If you find anything of this useful, you can [buy me a ☕](https://www.buymeacoffee.com/ubihazard "Donate")!
