class_name PauseStackSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var reasons: Array[String] = []

func push(reason: String) -> void:
	if not reasons.has(reason):
		reasons.append(reason)

func pop(reason: String) -> void:
	reasons.erase(reason)

func is_paused() -> bool:
	return not reasons.is_empty()

func top_reason() -> String:
	if reasons.is_empty():
		return ""
	return reasons[reasons.size() - 1]
