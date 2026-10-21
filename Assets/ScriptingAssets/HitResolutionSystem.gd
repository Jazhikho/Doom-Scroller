class_name HitResolutionSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

static func roll_hit(attack_total: int, defense_target: int) -> Dictionary:
	return {"hit": attack_total >= defense_target, "attack_total": attack_total, "defense_target": defense_target}

static func resolve_flat_damage(hit_result: Dictionary, damage_amount: int) -> int:
	if not bool(hit_result.get("hit", false)):
		return 0
	return max(0, damage_amount)
