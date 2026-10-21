class_name EquipmentSlotSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var slots: Dictionary = {}

func define_slot(slot_id: String, allowed_tags: Array[String] = []) -> void:
	slots[slot_id] = {"item_id": "", "allowed_tags": allowed_tags.duplicate()}

func equip(slot_id: String, item_id: String) -> bool:
	if not slots.has(slot_id):
		return false
	(slots[slot_id] as Dictionary)["item_id"] = item_id
	return true

func unequip(slot_id: String) -> String:
	if not slots.has(slot_id):
		return ""
	var previous: String = String((slots[slot_id] as Dictionary).get("item_id", ""))
	(slots[slot_id] as Dictionary)["item_id"] = ""
	return previous
