class_name EventBusSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var _listeners: Dictionary = {}
var _history: Array[Dictionary] = []
var max_history_size: int = 100

func subscribe(event_name: String, callback: Callable) -> void:
	if not _listeners.has(event_name):
		_listeners[event_name] = []
	var callbacks: Array = _listeners[event_name]
	if not callbacks.has(callback):
		callbacks.append(callback)

func unsubscribe(event_name: String, callback: Callable) -> void:
	if not _listeners.has(event_name):
		return
	var callbacks: Array = _listeners[event_name]
	callbacks.erase(callback)

func emit(event_name: String, payload: Variant = null) -> void:
	_history.append({"event": event_name, "payload": payload})
	while _history.size() > max_history_size:
		_history.pop_front()
	if not _listeners.has(event_name):
		return
	for callback: Callable in (_listeners[event_name] as Array).duplicate():
		if callback.is_valid():
			callback.call(payload)

func get_history(event_name: String = "") -> Array[Dictionary]:
	if event_name == "":
		return _history.duplicate()
	var filtered: Array[Dictionary] = []
	for item: Dictionary in _history:
		if String(item.get("event", "")) == event_name:
			filtered.append(item)
	return filtered
