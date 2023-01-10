import sublime, sublime_plugin
from pathlib import Path
import subprocess

#def plugin_loaded():
#	sublime.status_message('Session cleaner loaded')

class EventListener(sublime_plugin.EventListener):
	def on_exit(self):
		subprocess.Popen([str(Path.home()) + '/.local/bin/subl_clean_session'])
