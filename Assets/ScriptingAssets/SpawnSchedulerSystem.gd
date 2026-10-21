class_name SpawnSchedulerSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var groups: Dictionary = {}

func configure_group(group_id: String, interval_seconds: float, max_active: int = -1, weight: float = 1.0) -> void:
	groups[group_id] = {"interval": maxf(0.0, interval_seconds), "remaining": maxf(0.0, interval_seconds), "max_active": max_active, "active": 0, "weight": maxf(0.0, weight)}

func tick(delta_seconds: float) -> Array[String]:
	var ready: Array[String] = []
	for group_id: String in groups.keys():
		var group: Dictionary = groups[group_id]
		if int(group.get("max_active", -1)) >= 0 and int(group.get("active", 0)) >= int(group.get("max_active", -1)):
			continue
		group["remaining"] = float(group.get("remaining", 0.0)) - delta_seconds
		if float(group.get("remaining", 0.0)) <= 0.0:
			ready.append(group_id)
			group["remaining"] = float(group.get("interval", 0.0))
	return ready

func notify_spawned(group_id: String) -> void:
	if groups.has(group_id):
		var group: Dictionary = groups[group_id]
		group["active"] = int(group.get("active", 0)) + 1

func notify_removed(group_id: String) -> void:
	if groups.has(group_id):
		var group: Dictionary = groups[group_id]
		group["active"] = max(0, int(group.get("active", 0)) - 1)
