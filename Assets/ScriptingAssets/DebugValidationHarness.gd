class_name DebugValidationHarness
extends RefCounted

## UNTESTED: This reusable system has not been validated in a target project. Validate before production use.

var checks: Array[Dictionary] = []

func add_check(id: String, callback: Callable) -> void:
	checks.append({"id": id, "callback": callback})

func run_checks() -> Array[Dictionary]:
	var results: Array[Dictionary] = []
	for check: Dictionary in checks:
		var callback: Callable = check.get("callback", Callable())
		var passed: bool = false
		var message: String = ""
		if callback.is_valid():
			var result: Variant = callback.call()
			if result is Dictionary:
				passed = bool((result as Dictionary).get("passed", false))
				message = String((result as Dictionary).get("message", ""))
			else:
				passed = bool(result)
		results.append({"id": check.get("id", ""), "passed": passed, "message": message})
	return results
