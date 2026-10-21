class_name SpeakerRegistrySystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var speakers: Dictionary = {}

func register_speaker(id: String, display_name: String, metadata: Dictionary = {}) -> void:
	speakers[id] = {"display_name": display_name, "metadata": metadata.duplicate(true)}

func get_display_name(id: String) -> String:
	if not speakers.has(id):
		return id
	return String((speakers[id] as Dictionary).get("display_name", id))
