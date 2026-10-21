class_name BuySellValidationSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

static func can_buy(wallet: CurrencyWalletSystem, price: Dictionary) -> bool:
	return wallet.balance(String(price.get("currency", ""))) >= int(price.get("amount", 0))

static func has_price(price_table: PriceTableSystem, item_id: String) -> bool:
	return not price_table.get_price(item_id).is_empty()
