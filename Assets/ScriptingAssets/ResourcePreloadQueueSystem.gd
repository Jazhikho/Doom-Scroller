class_name ResourcePreloadQueueSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var queue: Array[String] = []
var loaded: Dictionary = {}
var failed: Array[String] = []

func enqueue(path: String) -> void:
	if not queue.has(path) and not loaded.has(path):
		queue.append(path)

func load_next() -> bool:
	if queue.is_empty():
		return false
	var path: String = queue.pop_front()
	var resource: Resource = load(path)
	if resource == null:
		failed.append(path)
		return false
	loaded[path] = resource
	return true

func get_resource(path: String) -> Resource:
	return loaded.get(path, null)
