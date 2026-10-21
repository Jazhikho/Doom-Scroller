class_name WorldLocationSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var locations: Dictionary = {}

func add_location(id: String, display_name: String, metadata: Dictionary = {}) -> void:
	locations[id] = {"display_name": display_name, "metadata": metadata.duplicate(true)}

func has_location(id: String) -> bool:
	return locations.has(id)
