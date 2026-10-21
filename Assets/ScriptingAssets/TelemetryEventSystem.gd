class_name TelemetryEventSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var events: Array[Dictionary] = []
var enabled: bool = true

func capture(event_name: String, properties: Dictionary = {}) -> void:
	if not enabled:
		return
	events.append({"event": event_name, "properties": properties.duplicate(true), "unix": Time.get_unix_time_from_system()})

func export_events(clear_after_export: bool = false) -> Array[Dictionary]:
	var copy: Array[Dictionary] = events.duplicate(true)
	if clear_after_export:
		events.clear()
	return copy
