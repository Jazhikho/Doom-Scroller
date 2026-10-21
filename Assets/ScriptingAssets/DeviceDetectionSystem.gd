class_name DeviceDetectionSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

const DEVICE_MOUSE_KEYBOARD: String = "mouse_keyboard"
const DEVICE_GAMEPAD: String = "gamepad"

var active_device: String = DEVICE_MOUSE_KEYBOARD

func observe_input(event: InputEvent) -> String:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		active_device = DEVICE_GAMEPAD
	elif event is InputEventKey or event is InputEventMouse:
		active_device = DEVICE_MOUSE_KEYBOARD
	return active_device

func get_display_name() -> String:
	if active_device == DEVICE_GAMEPAD:
		return "Controller"
	return "Keyboard and Mouse"
