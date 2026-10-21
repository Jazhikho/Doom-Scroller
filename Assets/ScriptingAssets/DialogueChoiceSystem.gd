class_name DialogueChoiceSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

static func filter_choices(choices: Array[Dictionary], condition_system: Object = null, flag_system: RuntimeFlagSystem = null) -> Array[Dictionary]:
	var output: Array[Dictionary] = []
	for choice: Dictionary in choices:
		if not choice.has("conditions") or condition_system == null or flag_system == null:
			output.append(choice)
		elif condition_system.conditions_met(choice.get("conditions", []), flag_system):
			output.append(choice)
	return output
