class_name PriceTableSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var prices: Dictionary = {}

func set_price(item_id: String, currency_id: String, amount: int) -> void:
	prices[item_id] = {"currency": currency_id, "amount": max(0, amount)}

func get_price(item_id: String) -> Dictionary:
	return prices.get(item_id, {})
