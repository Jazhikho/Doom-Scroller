class_name RuntimeLogSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var entries: Array[Dictionary] = []
var max_entries: int = 250

func record(category: String, message: String, data: Dictionary = {}) -> void:
	entries.append({"category": category, "message": message, "data": data.duplicate(true), "unix": Time.get_unix_time_from_system()})
	while entries.size() > max_entries:
		entries.pop_front()

func query(category: String = "") -> Array[Dictionary]:
	if category == "":
		return entries.duplicate(true)
	var output: Array[Dictionary] = []
	for entry: Dictionary in entries:
		if String(entry.get("category", "")) == category:
			output.append(entry)
	return output

func clear() -> void:
	entries.clear()
