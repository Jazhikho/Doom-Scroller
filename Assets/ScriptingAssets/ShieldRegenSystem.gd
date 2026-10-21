class_name ShieldRegenSystem
extends RefCounted

var recharge_delay := 2.0
var recharge_rate := 1.0
var _delay_remaining := 0.0

func configure(delay_seconds: float, rate_per_second: float) -> void:
	recharge_delay = max(0.0, delay_seconds)
	recharge_rate = max(0.0, rate_per_second)

func notify_damage() -> void:
	_delay_remaining = recharge_delay

func reset() -> void:
	_delay_remaining = 0.0

func tick(delta: float, current_shields: float, max_shields: float) -> float:
	if max_shields <= 0.0:
		return 0.0
	if current_shields >= max_shields:
		_delay_remaining = 0.0
		return max_shields
	if _delay_remaining > 0.0:
		_delay_remaining = max(0.0, _delay_remaining - delta)
		return current_shields
	if recharge_rate <= 0.0:
		return max_shields
	return min(max_shields, current_shields + recharge_rate * delta)
