Disable macOS accented characters:

```bash
defaults write com.sublimetext.4 ApplePressAndHoldEnabled -bool false
# For Sublime Text 3:
#defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false
```

Turn off hardware acceleration in `User/Preferences.sublime-settings` (default seems to be `opengl`):

```json
"hardware_acceleration": "none"
```
