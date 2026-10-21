class_name SceneServiceRegistry
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var services: Dictionary = {}

func register(id: String, service: Object) -> void:
	services[id] = service

func unregister(id: String) -> void:
	services.erase(id)

func get_service(id: String) -> Object:
	return services.get(id, null)

func has_service(id: String) -> bool:
	return services.has(id)
