class_name CooldownSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var _cooldowns: Dictionary = {}
var _charges: Dictionary = {}

func configure(id: String, duration: float, charges: int = 1) -> void:
	_cooldowns[id] = {"duration": maxf(0.0, duration), "remaining": 0.0}
	_charges[id] = {"max": max(1, charges), "current": max(1, charges)}

func tick(delta_seconds: float) -> void:
	for id: String in _cooldowns.keys():
		var item: Dictionary = _cooldowns[id]
		item["remaining"] = maxf(0.0, float(item.get("remaining", 0.0)) - delta_seconds)

func can_use(id: String) -> bool:
	return _charges.has(id) and int((_charges[id] as Dictionary).get("current", 0)) > 0 and float((_cooldowns[id] as Dictionary).get("remaining", 0.0)) <= 0.0

func consume(id: String) -> bool:
	if not can_use(id):
		return false
	var charge: Dictionary = _charges[id]
	charge["current"] = int(charge.get("current", 0)) - 1
	var cooldown: Dictionary = _cooldowns[id]
	cooldown["remaining"] = float(cooldown.get("duration", 0.0))
	return true

func refill(id: String) -> void:
	if _charges.has(id):
		(_charges[id] as Dictionary)["current"] = int((_charges[id] as Dictionary).get("max", 1))
