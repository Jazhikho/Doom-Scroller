class_name DamagePacketSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

static func build(amount: int, damage_type: String = "normal", source_id: String = "", tags: Array[String] = []) -> Dictionary:
	return {"amount": max(0, amount), "damage_type": damage_type, "source_id": source_id, "tags": tags.duplicate()}

static func scale(packet: Dictionary, multiplier: float) -> Dictionary:
	var copy: Dictionary = packet.duplicate(true)
	copy["amount"] = max(0, int(round(float(copy.get("amount", 0)) * multiplier)))
	return copy
