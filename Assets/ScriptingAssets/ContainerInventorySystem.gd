class_name ContainerInventorySystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var containers: Dictionary = {}

func define_container(id: String, capacity: int = -1) -> void:
	containers[id] = {"capacity": capacity, "items": []}

func add_item(container_id: String, item_id: String) -> bool:
	if not containers.has(container_id):
		return false
	var container: Dictionary = containers[container_id]
	var items: Array = container.get("items", [])
	if int(container.get("capacity", -1)) >= 0 and items.size() >= int(container.get("capacity", -1)):
		return false
	items.append(item_id)
	container["items"] = items
	return true
