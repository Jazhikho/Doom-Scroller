class_name InventoryTransactionSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

static func can_transfer(source: ContainerInventorySystem, target: ContainerInventorySystem, source_id: String, target_id: String, item_id: String) -> bool:
	if not source.containers.has(source_id) or not target.containers.has(target_id):
		return false
	return ((source.containers[source_id] as Dictionary).get("items", []) as Array).has(item_id)

static func transfer(source: ContainerInventorySystem, target: ContainerInventorySystem, source_id: String, target_id: String, item_id: String) -> bool:
	if not can_transfer(source, target, source_id, target_id, item_id):
		return false
	var source_items: Array = (source.containers[source_id] as Dictionary).get("items", [])
	source_items.erase(item_id)
	return target.add_item(target_id, item_id)
