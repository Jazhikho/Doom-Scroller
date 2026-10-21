class_name BranchingDialogueStateSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var current_node_id: String = ""
var visited: Array[String] = []

func start(node_id: String) -> void:
	current_node_id = node_id
	_mark_visited(node_id)

func choose(next_node_id: String) -> void:
	current_node_id = next_node_id
	_mark_visited(next_node_id)

func _mark_visited(node_id: String) -> void:
	if not visited.has(node_id):
		visited.append(node_id)
