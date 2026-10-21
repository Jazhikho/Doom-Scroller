class_name LocalizationTextSystem
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var tables: Dictionary = {}
var language: String = "en"
var fallback_language: String = "en"

func set_table(language_id: String, entries: Dictionary) -> void:
	tables[language_id] = entries.duplicate(true)

func set_language(language_id: String) -> void:
	language = language_id

func tr_key(key: String, variables: Dictionary = {}) -> String:
	var text: String = key
	if tables.has(language) and (tables[language] as Dictionary).has(key):
		text = String((tables[language] as Dictionary)[key])
	elif tables.has(fallback_language) and (tables[fallback_language] as Dictionary).has(key):
		text = String((tables[fallback_language] as Dictionary)[key])
	else:
		push_warning("LocalizationTextSystem missing key: " + key)
	for variable_name: String in variables.keys():
		text = text.replace("{" + variable_name + "}", str(variables[variable_name]))
	return text
