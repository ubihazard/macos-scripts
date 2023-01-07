# macOS Tweaks

After fresh install you might want to apply the following.

### Prevent .DS_Store creation

This doesn’t seem to work for external drives. Use [alternative file manager](https://ranger.github.io/ "ranger") instead of Finder to prevent `.DS_Store` literring everywhere (at least when working with external drives).

```bash
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
#defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
```

### Disable Time Machine prompts

```bash
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
```

### Enable always expanded save dialogs

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

### Allow Finder to quit

```bash
defaults write com.apple.finder QuitMenuItem -bool true
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
