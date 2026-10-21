class_name StatusEffectSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var effects: Dictionary = {}

func apply(id: String, stacks: int = 1, duration_turns: int = -1) -> void:
	var current: Dictionary = effects.get(id, {"stacks": 0, "duration_turns": duration_turns})
	current["stacks"] = int(current.get("stacks", 0)) + stacks
	current["duration_turns"] = duration_turns
	effects[id] = current

func tick_turn() -> void:
	for id: String in effects.keys():
		var effect: Dictionary = effects[id]
		var duration: int = int(effect.get("duration_turns", -1))
		if duration > 0:
			effect["duration_turns"] = duration - 1
	for id: String in effects.keys():
		if int((effects[id] as Dictionary).get("duration_turns", -1)) == 0:
			effects.erase(id)

func has_effect(id: String) -> bool:
	return effects.has(id)
