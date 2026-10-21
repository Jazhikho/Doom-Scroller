class_name CurrencyWalletSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var balances: Dictionary = {}

func add(currency_id: String, amount: int) -> void:
	balances[currency_id] = max(0, int(balances.get(currency_id, 0)) + amount)

func spend(currency_id: String, amount: int) -> bool:
	if int(balances.get(currency_id, 0)) < amount:
		return false
	balances[currency_id] = int(balances.get(currency_id, 0)) - amount
	return true

func balance(currency_id: String) -> int:
	return int(balances.get(currency_id, 0))
