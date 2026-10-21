class_name TravelLinkSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var links: Dictionary = {}

func add_link(from_id: String, to_id: String, cost: int = 0) -> void:
	if not links.has(from_id):
		links[from_id] = []
	(links[from_id] as Array).append({"to": to_id, "cost": max(0, cost)})

func get_links(from_id: String) -> Array:
	return (links.get(from_id, []) as Array).duplicate(true)
