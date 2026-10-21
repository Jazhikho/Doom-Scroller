class_name NotificationQueueSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var queue: Array[Dictionary] = []

func push(id: String, text: String, priority: int = 0, seconds: float = 3.0, dedupe: bool = true) -> void:
	if dedupe:
		for item: Dictionary in queue:
			if String(item.get("id", "")) == id:
				item["text"] = text
				item["remaining"] = seconds
				item["priority"] = priority
				return
	queue.append({"id": id, "text": text, "priority": priority, "remaining": maxf(0.0, seconds)})
	queue.sort_custom(func(a: Dictionary, b: Dictionary) -> bool: return int(a.get("priority", 0)) > int(b.get("priority", 0)))

func tick(delta_seconds: float) -> void:
	for item: Dictionary in queue:
		item["remaining"] = float(item.get("remaining", 0.0)) - delta_seconds
	queue = queue.filter(func(item: Dictionary) -> bool: return float(item.get("remaining", 0.0)) > 0.0)

func current() -> Dictionary:
	if queue.is_empty():
		return {}
	return queue[0]
