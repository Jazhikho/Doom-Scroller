class_name DialogueConsequenceSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

func apply_consequences(consequences: Array[Dictionary], flag_system: RuntimeFlagSystem) -> void:
	for consequence: Dictionary in consequences:
		var action: String = String(consequence.get("action", "set_flag"))
		var key: String = String(consequence.get("key", ""))
		if action == "set_flag":
			flag_system.set_flag(key, consequence.get("value", true))
		elif action == "increment":
			flag_system.increment(key, int(consequence.get("amount", 1)))
