class_name TutorialSuppressionSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var suppressed: Dictionary = {}

func suppress(id: String) -> void:
	suppressed[id] = true

func unsuppress(id: String) -> void:
	suppressed.erase(id)

func is_suppressed(id: String) -> bool:
	return bool(suppressed.get(id, false))
