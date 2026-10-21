class_name QuestObjectiveStateSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var objectives: Dictionary = {}

func add_objective(id: String, target_count: int = 1) -> void:
	objectives[id] = {"state": "active", "count": 0, "target": max(1, target_count)}

func advance(id: String, amount: int = 1) -> void:
	if not objectives.has(id):
		return
	var objective: Dictionary = objectives[id]
	objective["count"] = mini(int(objective.get("target", 1)), int(objective.get("count", 0)) + amount)
	if int(objective.get("count", 0)) >= int(objective.get("target", 1)):
		objective["state"] = "completed"

func fail(id: String) -> void:
	if objectives.has(id):
		(objectives[id] as Dictionary)["state"] = "failed"

func get_state(id: String) -> String:
	if not objectives.has(id):
		return "missing"
	return String((objectives[id] as Dictionary).get("state", "active"))
