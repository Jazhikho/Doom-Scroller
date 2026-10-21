class_name CombatHealthSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var max_health: int = 1
var health: int = 1

func configure(maximum: int, current: int = -1) -> void:
	max_health = max(1, maximum)
	health = max_health if current < 0 else clampi(current, 0, max_health)

func apply_damage(amount: int) -> int:
	var applied: int = mini(health, max(0, amount))
	health -= applied
	return applied

func heal(amount: int) -> int:
	var before: int = health
	health = mini(max_health, health + max(0, amount))
	return health - before

func is_empty() -> bool:
	return health <= 0
