class_name ResistanceSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var multipliers: Dictionary = {}

func set_multiplier(damage_type: String, multiplier: float) -> void:
	multipliers[damage_type] = maxf(0.0, multiplier)

func get_multiplier(damage_type: String) -> float:
	return float(multipliers.get(damage_type, 1.0))

func apply_to_packet(packet: Dictionary) -> Dictionary:
	var damage_type: String = String(packet.get("damage_type", "normal"))
	var copy: Dictionary = packet.duplicate(true)
	copy["amount"] = max(0, int(round(float(copy.get("amount", 0)) * get_multiplier(damage_type))))
	return copy
