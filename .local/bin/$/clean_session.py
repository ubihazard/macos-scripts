import sublime, sublime_plugin
import subprocess

#def plugin_loaded():
#	sublime.status_message('Session cleaner loaded')

class EventListener(sublime_plugin.EventListener):
	def on_exit(self):
		subprocess.Popen(['subl_clean_session'])
