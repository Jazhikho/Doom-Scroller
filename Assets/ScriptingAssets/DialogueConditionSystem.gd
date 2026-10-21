class_name DialogueConditionSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

func conditions_met(conditions: Array[Dictionary], flag_system: RuntimeFlagSystem) -> bool:
	for condition: Dictionary in conditions:
		var key: String = String(condition.get("key", ""))
		var expected: Variant = condition.get("equals", true)
		if flag_system.get_flag(key, null) != expected:
			return false
	return true
