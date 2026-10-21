class_name StateMachineSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var state: String = ""
var transitions: Dictionary = {}

func configure(initial_state: String) -> void:
	state = initial_state

func allow_transition(from_state: String, to_state: String) -> void:
	if not transitions.has(from_state):
		transitions[from_state] = []
	var targets: Array = transitions[from_state]
	if not targets.has(to_state):
		targets.append(to_state)

func can_transition(to_state: String) -> bool:
	if not transitions.has(state):
		return false
	return (transitions[state] as Array).has(to_state)

func transition(to_state: String) -> bool:
	if not can_transition(to_state):
		return false
	state = to_state
	return true
