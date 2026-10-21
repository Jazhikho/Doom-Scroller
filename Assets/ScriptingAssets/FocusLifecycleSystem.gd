class_name FocusLifecycleSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var is_focused: bool = true
var should_pause_audio: bool = true
var should_release_input: bool = true

func handle_notification(what: int) -> Dictionary:
	if what == Node.NOTIFICATION_APPLICATION_FOCUS_OUT or what == Node.NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		is_focused = false
		return {"focused": false, "pause_audio": should_pause_audio, "release_input": should_release_input}
	if what == Node.NOTIFICATION_APPLICATION_FOCUS_IN or what == Node.NOTIFICATION_WM_WINDOW_FOCUS_IN:
		is_focused = true
		return {"focused": true, "pause_audio": false, "release_input": false}
	return {}
