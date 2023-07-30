import sublime, sublime_plugin
from pathlib import Path
import subprocess

#def plugin_loaded():
#	sublime.status_message('Session reset plugin loaded')

class EventListener(sublime_plugin.EventListener):
	def on_exit(self):
		subprocess.Popen([str(Path.home()) + '/.local/bin/_/subl_text_session_reset.sh'])
