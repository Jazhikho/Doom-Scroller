class_name TutorialCompletionSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var completed: Dictionary = {}

func mark_completed(id: String) -> void:
	completed[id] = true

func is_completed(id: String) -> bool:
	return bool(completed.get(id, false))

func reset(id: String) -> void:
	completed.erase(id)
