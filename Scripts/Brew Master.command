#!/bin/bash

# Create `brewmaster` system user account for Homebrew.

id=$1
if [ $# -eq 0 ]; then
  id=777
fi

# Check if brewmaster account already exists
dscl . list /Users | grep "brewmaster" > /dev/null
[ $? == 0 ] && echo "Brew Master user has already been created" && exit 1

# Ensure no other user has specified id!
dscl . list /Users UniqueID | grep $id > /dev/null
[ $? == 0 ] && echo "Specified ID is already taken" && exit 1

# Create user
sudo dscl . create /Users/brewmaster
sudo dscl . passwd /Users/brewmaster
sudo dscl . create /Users/brewmaster RealName "Brew Master"
sudo dscl . create /Users/brewmaster UserShell /bin/bash
sudo dscl . append /Groups/admin GroupMembership brewmaster

# IDs
sudo dscl . create /Users/brewmaster UniqueID $id
sudo dscl . create /Users/brewmaster PrimaryGroupID 80

# Home directory
sudo dscl . create /Users/brewmaster NFSHomeDirectory /var/brewmaster
sudo mkdir /var/brewmaster
sudo chown brewmaster:admin /var/brewmaster

# Hide on login screen
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWOTHERUSERS_MANAGED -bool false
sudo defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool true
sudo dscl . create /Users/brewmaster IsHidden 1

# Success
echo "Successfully created Brew Master user for Homebrew\n"
dscl . list /Users | grep -v _
