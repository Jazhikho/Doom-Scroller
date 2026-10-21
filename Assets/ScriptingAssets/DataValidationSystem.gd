class_name DataValidationSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var issues: Array[Dictionary] = []

func clear() -> void:
	issues.clear()

func require_key(context: String, data: Dictionary, key: String) -> void:
	if not data.has(key):
		issues.append({"context": context, "severity": "error", "message": "Missing key: " + key})

func require_unique_ids(context: String, items: Array, id_key: String = "id") -> void:
	var seen: Dictionary = {}
	for item_variant: Variant in items:
		if not (item_variant is Dictionary):
			continue
		var item: Dictionary = item_variant
		var id: String = String(item.get(id_key, ""))
		if id == "":
			issues.append({"context": context, "severity": "error", "message": "Missing id"})
		elif seen.has(id):
			issues.append({"context": context, "severity": "error", "message": "Duplicate id: " + id})
		seen[id] = true

func is_valid() -> bool:
	return issues.is_empty()
