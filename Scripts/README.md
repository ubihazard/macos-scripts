# macOS tweaks

## General tweaks

After fresh install you might want to apply the following.

### Prevent .DS_Store creation

```bash
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
#defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
```

This doesn’t seem to work for external drives (nor it have ever worked in older versions of macOS). Use [alternative file manager](https://ranger.github.io/ "ranger") instead of Finder to prevent `.DS_Store` literring everywhere.

### Disable Time Machine prompts

```bash
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
```

### Enable always-expanded save dialogs

```bash
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
```

### Disable version control for specific apps

```bash
defaults write -app 'Sketch' ApplePersistence -bool no
defaults write -app 'Pixelmator' ApplePersistence -bool no
defaults write -app 'Pixelmator Pro' ApplePersistence -bool no
```

### Clear Finder Go to “Folder...” history

```bash
defaults delete com.apple.finder GoToField
defaults delete com.apple.finder GoToFieldHistory
```

### Allow Finder to quit

```bash
defaults write com.apple.finder QuitMenuItem -bool true
```

### Turn hibernation off

```bash
sudo pmset -a hibernatemode 0
```

Now you can also remove the sleep image (preserves RAM contents during sleep), freeing up some space on your SSD, which can be precious on some lower end Macs.

```bash
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```

If you are on a hackintosh, turning hibernation off is necessary because “deep” sleep is not really supported on hacks.

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

### Rebuild kernel cache

Up until Big Sur rebuilding of the kernel kext cache could be done with:

```bash
sudo kextcache -i / && sudo kextcache -u /
```

On Catalina the root volume [has to be mounted in write mode](#mount-root-volume-as-writable).

See [below](#rebuild-kernel-cache-1) how to rebuild kext cache in Big Sur.

## Catalina

### Mount root volume as writable

In Catalina the root volume is mounted read-only. Before any changes could be made to it, you need to re-mount it as writable:

```bash
sudo mount -uw /
```

## Big Sur

### Root patching

Big Sur makes the process even more <s>annoying</s> involving. The root volume is “snapshotted” and you need to perform the following commands to modify the `/System`:

```bash
mkdir -p ~/.local/root
sudo mount -o nobrowse -t apfs /dev/diskXsY ~/.local/root
echo your changes here...
sudo bless --folder ~/.local/root/System/Library/CoreServices --bootefi --create-snapshot
sudo umount ~/.local/root
rmdir ~/.local/root
```

`diskXsY` can be obtained from `diskutil list`.

### Rebuild kernel cache

Rebuilding kernel cache is also different in Big Sur. Run the following command before `bless`ing and creating a snapshot if you’ve made changes to the system‘s kernel extensions:

```bash
sudo kmutil install --force --update-all --volume-root ~/.local/root
```

### Change the sleep timeout

Big Sur seemingly removed ability to set the timeout when machine goes to sleep independently from the display sleep timeout. It can still be configured using command line (in minutes):

```bash
sudo pmset -a sleep 30
```

## Spotlight

### Erase (and rebuild) index on volume

```bash
sudo mdutil -E /Volumes/Data
```

### Disable searching of volume

```bash
sudo mdutil -d /Volumes/Data
```

### Disable indexing of volume

```bash
sudo mdutil -i off /Volumes/Data
```

### Disable Spotlight on all volumes

```bash
sudo mdutil -a -E
sudo mdutil -a -d
sudo mdutil -a -i off
```

# ⭐ Support

If you find anything of this useful, you can [buy me a ☕](https://www.buymeacoffee.com/ubihazard "Donate")!
