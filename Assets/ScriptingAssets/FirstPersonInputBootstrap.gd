class_name FirstPersonInputBootstrap
extends RefCounted

## PURPOSE:
## Optional fallback that registers default first-person move/look InputMap actions when missing.
##
## USE WHEN:
## Dropping FirstPersonMovementController into an empty project that has no Input Map yet.
##
## DO NOT USE WHEN:
## This game already defines the actions in Project Settings -> Input Map (preferred).
## Remapping UI / persistence belong in separate control/settings systems.
##
## OWNS:
## Default action-name constants and one-shot InputMap event registration.
##
## CALLER MUST PROVIDE:
## An explicit call to ensure_default_actions(), or auto_register_missing_input_actions = true.
##
## GAME-SPECIFIC GLUE BELONGS:
## In project.godot Input Map entries and accessibility remappers.

const ACTION_MOVE_FORWARD: String = "move_forward"
const ACTION_MOVE_BACK: String = "move_back"
const ACTION_MOVE_LEFT: String = "move_left"
const ACTION_MOVE_RIGHT: String = "move_right"
const ACTION_LOOK_UP: String = "look_up"
const ACTION_LOOK_DOWN: String = "look_down"
const ACTION_LOOK_LEFT: String = "look_left"
const ACTION_LOOK_RIGHT: String = "look_right"


## ensure_default_actions
## Purpose: Create the standard move/look actions and keyboard/gamepad bindings if missing.
## Returns: void
static func ensure_default_actions() -> void:
	_ensure_key_action(ACTION_MOVE_FORWARD, KEY_W, JOY_AXIS_LEFT_Y, -1.0)
	_ensure_key_action(ACTION_MOVE_BACK, KEY_S, JOY_AXIS_LEFT_Y, 1.0)
	_ensure_key_action(ACTION_MOVE_LEFT, KEY_A, JOY_AXIS_LEFT_X, -1.0)
	_ensure_key_action(ACTION_MOVE_RIGHT, KEY_D, JOY_AXIS_LEFT_X, 1.0)
	_ensure_axis_action(ACTION_LOOK_UP, JOY_AXIS_RIGHT_Y, -1.0)
	_ensure_axis_action(ACTION_LOOK_DOWN, JOY_AXIS_RIGHT_Y, 1.0)
	_ensure_axis_action(ACTION_LOOK_LEFT, JOY_AXIS_RIGHT_X, -1.0)
	_ensure_axis_action(ACTION_LOOK_RIGHT, JOY_AXIS_RIGHT_X, 1.0)


## _ensure_key_action
## Purpose: Ensure an action exists with a keyboard key and matching stick axis binding.
## Parameters: action_name - InputMap action id. keycode - Keyboard key. axis - Joypad axis. axis_value - Axis direction (-1 or 1).
## Returns: void
static func _ensure_key_action(action_name: String, keycode: Key, axis: JoyAxis, axis_value: float) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name, 0.2)
	if not _action_has_keycode(action_name, keycode):
		var key_event: InputEventKey = InputEventKey.new()
		key_event.physical_keycode = keycode
		InputMap.action_add_event(action_name, key_event)
	if not _action_has_joy_axis(action_name, axis, axis_value):
		var axis_event: InputEventJoypadMotion = InputEventJoypadMotion.new()
		axis_event.axis = axis
		axis_event.axis_value = axis_value
		InputMap.action_add_event(action_name, axis_event)


## _ensure_axis_action
## Purpose: Ensure a look action exists with a joypad axis binding.
## Parameters: action_name - InputMap action id. axis - Joypad axis. axis_value - Axis direction (-1 or 1).
## Returns: void
static func _ensure_axis_action(action_name: String, axis: JoyAxis, axis_value: float) -> void:
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name, 0.2)
	if not _action_has_joy_axis(action_name, axis, axis_value):
		var axis_event: InputEventJoypadMotion = InputEventJoypadMotion.new()
		axis_event.axis = axis
		axis_event.axis_value = axis_value
		InputMap.action_add_event(action_name, axis_event)


## _action_has_keycode
## Purpose: Detect whether an action already contains a given physical key binding.
## Parameters: action_name - InputMap action id. keycode - Keyboard key to find.
## Returns: true when the key binding already exists.
static func _action_has_keycode(action_name: String, keycode: Key) -> bool:
	var events: Array = InputMap.action_get_events(action_name)
	for event_variant: Variant in events:
		if event_variant is InputEventKey:
			var key_event: InputEventKey = event_variant as InputEventKey
			if key_event.physical_keycode == keycode:
				return true
	return false


## _action_has_joy_axis
## Purpose: Detect whether an action already contains a given joypad axis binding.
## Parameters: action_name - InputMap action id. axis - Joypad axis. axis_value - Axis direction.
## Returns: true when the axis binding already exists.
static func _action_has_joy_axis(action_name: String, axis: JoyAxis, axis_value: float) -> bool:
	var events: Array = InputMap.action_get_events(action_name)
	for event_variant: Variant in events:
		if event_variant is InputEventJoypadMotion:
			var axis_event: InputEventJoypadMotion = event_variant as InputEventJoypadMotion
			if axis_event.axis != axis:
				continue
			if is_equal_approx(axis_event.axis_value, axis_value):
				return true
	return false
