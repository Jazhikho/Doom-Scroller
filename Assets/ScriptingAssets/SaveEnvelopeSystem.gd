class_name SaveEnvelopeSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

static func build_envelope(version: int, slot_id: String, payload: Dictionary, metadata: Dictionary = {}) -> Dictionary:
	return {
		"version": version,
		"slot_id": slot_id,
		"saved_unix": Time.get_unix_time_from_system(),
		"metadata": metadata.duplicate(true),
		"payload": payload.duplicate(true),
	}

static func is_compatible(envelope: Dictionary, current_version: int, minimum_supported_version: int = 1) -> bool:
	var version: int = int(envelope.get("version", 0))
	return version >= minimum_supported_version and version <= current_version

static func migrate(envelope: Dictionary, current_version: int, migration_callbacks: Dictionary) -> Dictionary:
	var migrated: Dictionary = envelope.duplicate(true)
	var version: int = int(migrated.get("version", 0))
	while version < current_version:
		var next_version: int = version + 1
		var callback: Callable = migration_callbacks.get(next_version, Callable())
		if not callback.is_valid():
			push_error("SaveEnvelopeSystem.migrate missing migration for version %s" % next_version)
			break
		migrated = callback.call(migrated)
		version = int(migrated.get("version", next_version))
	return migrated
