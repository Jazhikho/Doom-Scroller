class_name ProgressionUnlockSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var unlocks: Dictionary = {}

func define_unlock(id: String, requirements: Array[String] = []) -> void:
	unlocks[id] = {"requirements": requirements.duplicate(), "unlocked": false}

func is_available(id: String) -> bool:
	if not unlocks.has(id):
		return false
	for requirement: String in (unlocks[id] as Dictionary).get("requirements", []):
		if not is_unlocked(requirement):
			return false
	return true

func unlock(id: String) -> bool:
	if not is_available(id):
		return false
	(unlocks[id] as Dictionary)["unlocked"] = true
	return true

func is_unlocked(id: String) -> bool:
	return unlocks.has(id) and bool((unlocks[id] as Dictionary).get("unlocked", false))
