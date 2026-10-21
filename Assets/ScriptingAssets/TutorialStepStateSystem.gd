class_name TutorialStepStateSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var steps: Dictionary = {}
var active_step_id: String = ""

func define_step(id: String, required_previous: Array[String] = []) -> void:
	steps[id] = {"state": "available", "required_previous": required_previous.duplicate()}

func start(id: String) -> bool:
	if not steps.has(id):
		return false
	active_step_id = id
	(steps[id] as Dictionary)["state"] = "active"
	return true

func complete(id: String) -> void:
	if steps.has(id):
		(steps[id] as Dictionary)["state"] = "completed"
		if active_step_id == id:
			active_step_id = ""
