class_name TargetLockSystem
extends RefCounted

var _target_ref: WeakRef = null

func get_target() -> Node:
	if _target_ref == null:
		return null
	var target: Variant = _target_ref.get_ref()
	if target is Node and is_instance_valid(target):
		return target as Node
	return null

func set_target(target: Node) -> void:
	_target_ref = weakref(target) if target != null else null

func clear() -> void:
	_target_ref = null

func lock_nearest(candidates: Array, origin: Node2D) -> Node:
	var sorted := sorted_by_distance(candidates, origin)
	if sorted.is_empty():
		clear()
		return null
	set_target(sorted[0])
	return sorted[0]

func cycle(candidates: Array, origin: Node2D) -> Node:
	var sorted := sorted_by_distance(candidates, origin)
	if sorted.is_empty():
		clear()
		return null
	var current := get_target()
	if current == null:
		set_target(sorted[0])
		return sorted[0]
	var index := sorted.find(current)
	if index == -1 or sorted.size() == 1:
		set_target(sorted[0])
	else:
		set_target(sorted[(index + 1) % sorted.size()])
	return get_target()

func sorted_by_distance(candidates: Array, origin: Node2D) -> Array:
	var sorted := []
	if origin == null:
		return sorted
	for candidate in candidates:
		if candidate is Node2D and is_instance_valid(candidate):
			sorted.append(candidate)
	sorted.sort_custom(func(a, b): return origin.position.distance_squared_to(a.position) < origin.position.distance_squared_to(b.position))
	return sorted
