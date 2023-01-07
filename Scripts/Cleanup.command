#!/bin/bash

cd "$HOME"
[ $? -ne 0 ] && exit 1

# History
rm -f .bash_history
rm -f .bash_sessions/*
rmdir .bash_sessions
rm -f .lesshs*
rm -f .node_repl_history
rm -f .mysql_history
rm -f .mysqlsh/*
rmdir .mysqlsh
rm -f .dbshell
rm -f .rediscli_history
rm -f .viminfo

# ranger file manager
which ranger > /dev/null
if [ $? -eq 0 ]; then
  rm -rf .cache/ranger
  rm -rf .local/share/ranger
fi

# gotop process monitor
which gotop > /dev/null
if [ $? -eq 0 ]; then
  rm -rf .local/state/gotop
fi

# npm logs
which npm > /dev/null
[ $? -eq 0 ] && rm -f .npm/_logs/*
