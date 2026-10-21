class_name ItemStackSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var stacks: Dictionary = {}

func add_item(item_id: String, count: int = 1) -> void:
	stacks[item_id] = max(0, int(stacks.get(item_id, 0)) + count)

func remove_item(item_id: String, count: int = 1) -> bool:
	if int(stacks.get(item_id, 0)) < count:
		return false
	stacks[item_id] = int(stacks.get(item_id, 0)) - count
	return true

func get_count(item_id: String) -> int:
	return int(stacks.get(item_id, 0))
