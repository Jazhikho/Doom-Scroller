class_name EconomyTransactionSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

static func buy(wallet: CurrencyWalletSystem, price: Dictionary) -> bool:
	return wallet.spend(String(price.get("currency", "")), int(price.get("amount", 0)))

static func sell(wallet: CurrencyWalletSystem, price: Dictionary, sell_multiplier: float = 0.5) -> int:
	var amount: int = max(0, int(round(float(price.get("amount", 0)) * sell_multiplier)))
	wallet.add(String(price.get("currency", "")), amount)
	return amount
