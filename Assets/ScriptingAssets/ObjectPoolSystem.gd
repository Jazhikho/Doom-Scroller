class_name ObjectPoolSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var _factory: Callable
var _available: Array[Node] = []
var _active: Array[Node] = []

func configure(factory: Callable) -> void:
	_factory = factory

func acquire() -> Node:
	var node: Node = null
	if not _available.is_empty():
		node = _available.pop_back()
	elif _factory.is_valid():
		node = _factory.call()
	if node != null:
		_active.append(node)
	return node

func release(node: Node) -> void:
	if node == null:
		return
	_active.erase(node)
	if not _available.has(node):
		_available.append(node)

func active_count() -> int:
	return _active.size()
