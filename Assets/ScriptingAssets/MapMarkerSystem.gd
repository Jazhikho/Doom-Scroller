class_name MapMarkerSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var markers: Dictionary = {}

func set_marker(id: String, location_id: String, marker_type: String, data: Dictionary = {}) -> void:
	markers[id] = {"location_id": location_id, "type": marker_type, "data": data.duplicate(true)}

func remove_marker(id: String) -> void:
	markers.erase(id)

func list_markers() -> Array[Dictionary]:
	var output: Array[Dictionary] = []
	for id: String in markers.keys():
		var marker: Dictionary = (markers[id] as Dictionary).duplicate(true)
		marker["id"] = id
		output.append(marker)
	return output
