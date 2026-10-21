class_name DiscoveryStateSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var discovered: Dictionary = {}
var visited: Dictionary = {}

func mark_discovered(id: String) -> void:
	discovered[id] = true

func mark_visited(id: String) -> void:
	mark_discovered(id)
	visited[id] = true

func is_discovered(id: String) -> bool:
	return bool(discovered.get(id, false))
