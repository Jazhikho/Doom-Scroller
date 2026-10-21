class_name InputRebindingSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var defaults: Dictionary = {}
var bindings: Dictionary = {}

func configure_default(action_name: String, events: Array[InputEvent]) -> void:
	defaults[action_name] = events.duplicate(true)
	if not bindings.has(action_name):
		bindings[action_name] = events.duplicate(true)

func set_binding(action_name: String, events: Array[InputEvent]) -> void:
	bindings[action_name] = events.duplicate(true)

func reset_action(action_name: String) -> void:
	if defaults.has(action_name):
		bindings[action_name] = (defaults[action_name] as Array).duplicate(true)

func apply_to_input_map() -> void:
	for action_name: String in bindings.keys():
		if not InputMap.has_action(action_name):
			InputMap.add_action(action_name)
		InputMap.action_erase_events(action_name)
		for event: InputEvent in bindings[action_name]:
			InputMap.action_add_event(action_name, event)

func export_bindings() -> Dictionary:
	return bindings.duplicate(true)
