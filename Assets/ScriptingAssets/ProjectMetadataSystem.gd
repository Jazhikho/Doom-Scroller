class_name ProjectMetadataSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var project_id: String = ""
var display_name: String = ""
var version: String = "0.0.0.0"
var build_channel: String = "dev"
var save_compatibility_version: int = 1

func configure(data: Dictionary) -> void:
	project_id = String(data.get("project_id", project_id))
	display_name = String(data.get("display_name", display_name))
	version = String(data.get("version", version))
	build_channel = String(data.get("build_channel", build_channel))
	save_compatibility_version = int(data.get("save_compatibility_version", save_compatibility_version))

func export_state() -> Dictionary:
	return {
		"project_id": project_id,
		"display_name": display_name,
		"version": version,
		"build_channel": build_channel,
		"save_compatibility_version": save_compatibility_version,
	}
