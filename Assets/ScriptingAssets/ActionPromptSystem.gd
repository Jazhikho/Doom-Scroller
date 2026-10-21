class_name ActionPromptSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var prompts: Dictionary = {}

func set_prompt(action_name: String, device_name: String, display_text: String) -> void:
	if not prompts.has(action_name):
		prompts[action_name] = {}
	(prompts[action_name] as Dictionary)[device_name] = display_text

func get_prompt(action_name: String, device_name: String, fallback_device: String = "keyboard") -> String:
	if not prompts.has(action_name):
		return action_name
	var device_prompts: Dictionary = prompts[action_name]
	if device_prompts.has(device_name):
		return String(device_prompts[device_name])
	return String(device_prompts.get(fallback_device, action_name))

func build_prompt_line(action_names: Array[String], device_name: String) -> String:
	var parts: Array[String] = []
	for action_name: String in action_names:
		parts.append(get_prompt(action_name, device_name))
	return " / ".join(parts)
