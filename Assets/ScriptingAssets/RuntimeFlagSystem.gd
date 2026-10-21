class_name RuntimeFlagSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var flags: Dictionary = {}

func set_flag(key: String, value: Variant = true) -> void:
	flags[key] = value

func get_flag(key: String, default_value: Variant = false) -> Variant:
	return flags.get(key, default_value)

func has_flag(key: String) -> bool:
	return flags.has(key)

func increment(key: String, amount: int = 1) -> int:
	var next_value: int = int(flags.get(key, 0)) + amount
	flags[key] = next_value
	return next_value

func export_state() -> Dictionary:
	return flags.duplicate(true)

func import_state(data: Dictionary) -> void:
	flags = data.duplicate(true)
