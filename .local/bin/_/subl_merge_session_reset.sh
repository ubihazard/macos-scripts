#!/bin/bash

dst="$HOME/Library/Application Support/Sublime Merge/Local/Session.sublime_session"
src="${dst}_clean"

sleep 2
[ -f "$src" ] && cp "$src" "$dst"
