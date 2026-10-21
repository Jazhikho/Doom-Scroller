class_name InitiativeTurnOrderSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var actors: Array[Dictionary] = []

func set_actors(actor_entries: Array[Dictionary]) -> void:
	actors = actor_entries.duplicate(true)
	actors.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return int(a.get("initiative", 0)) > int(b.get("initiative", 0)))

func next_actor_index(current_index: int) -> int:
	if actors.is_empty():
		return -1
	return (current_index + 1) % actors.size()

func get_actor(index: int) -> Dictionary:
	if index < 0 or index >= actors.size():
		return {}
	return actors[index]
