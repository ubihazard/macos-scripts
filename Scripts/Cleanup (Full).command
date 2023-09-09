#!/bin/bash

"`dirname "$0"`/Cleanup.command"

cd "$HOME"
[ $? -ne 0 ] && exit 1

# Ruby old gems
which gem > /dev/null
[ $? -eq 0 ] && gem cleanup

# npm cache
which npm > /dev/null
[ $? -eq 0 ] && npm cache clean --force

# Sublime Text
if [ -d "Library/Application Support/Sublime Text 3" ]; then
  rm -rf "Library/Application Support/Sublime Text 3/Cache"
  rm -rf "Library/Application Support/Sublime Text 3/Index"
fi

if [ -d "Library/Caches/Sublime Text" ]; then
  rm -rf "Library/Caches/Sublime Text/Cache"
fi

# Sublime Merge
if [ -d "Library/Application Support/Sublime Merge" ]; then
  rm -rf "Library/Application Support/Sublime Merge/Cache"
  rm -rf "Library/Application Support/Sublime Merge/Index"
fi

if [ -d "Library/Caches/Sublime Merge" ]; then
  rm -rf "Library/Caches/Sublime Merge/Cache"
fi

# Visual Studio Code
if [ -d "Applications/code-portable-data" ]; then
  rm -rf "Applications/code-portable-data/user-data/Backups"
  rm -rf "Applications/code-portable-data/user-data/Cache"
  rm -rf "Applications/code-portable-data/user-data/CachedData"
  rm -rf "Applications/code-portable-data/user-data/CachedExtensionVSIXs"
  rm -rf "Applications/code-portable-data/user-data/CachedExtensions"
  rm -rf "Applications/code-portable-data/user-data/Code Cache"
  rm  -f "Applications/code-portable-data/user-data/"Cookie*
  rm -rf "Applications/code-portable-data/user-data/Crashpad"
  rm  -f "Applications/code-portable-data/user-data/"Crashpad*
  rm -rf "Applications/code-portable-data/user-data/GPUCache"
  rm -rf "Applications/code-portable-data/user-data/Local Storage"
  rm -rf "Applications/code-portable-data/user-data/Session Storage"
  rm -rf "Applications/code-portable-data/user-data/User/workspaceStorage"
  rm -rf "Applications/code-portable-data/user-data/logs"
fi
