#!/bin/bash

brew doctor
brew cleanup -s
rm -rf `brew --cache`
rm -rf "$HOME/Library/Logs/Homebrew"
