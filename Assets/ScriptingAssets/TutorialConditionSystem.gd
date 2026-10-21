class_name TutorialConditionSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

func can_start(step_id: String, tutorial_state: TutorialStepStateSystem) -> bool:
	if not tutorial_state.steps.has(step_id):
		return false
	for required_id: String in (tutorial_state.steps[step_id] as Dictionary).get("required_previous", []):
		if String((tutorial_state.steps.get(required_id, {}) as Dictionary).get("state", "")) != "completed":
			return false
	return true
