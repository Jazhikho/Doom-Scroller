extends RefCounted
class_name PointDefenseSystem

var cooldown := 0.0

func reset() -> void:
	cooldown = 0.0

func tick(delta: float, fire_rate: float) -> bool:
	if fire_rate <= 0.0:
		return false
	cooldown = max(0.0, cooldown - delta)
	if cooldown > 0.0:
		return false
	cooldown = 1.0 / max(0.1, fire_rate)
	return true

func select_target(origin: Vector2, selection_range: float, projectiles: Array, asteroids: Array, enemies: Array) -> Dictionary:
	var projectile: Node2D = _nearest_projectile(origin, selection_range, projectiles)
	if projectile != null:
		return {"type": "projectile", "target": projectile}
	var asteroid := _nearest_asteroid(origin, selection_range, asteroids)
	if asteroid.has("tile_data"):
		return {"type": "asteroid", "tile_data": asteroid["tile_data"], "rect": asteroid["rect"]}
	var enemy: Node2D = _nearest_enemy(origin, selection_range, enemies)
	if enemy != null:
		return {"type": "enemy", "target": enemy}
	return {}

func _nearest_projectile(origin: Vector2, selection_range: float, projectiles: Array):
	var nearest = null
	var nearest_distance := selection_range
	for projectile in projectiles:
		if not is_instance_valid(projectile) or projectile.source != "enemy":
			continue
		var distance := origin.distance_to(projectile.position)
		if distance <= nearest_distance:
			nearest = projectile
			nearest_distance = distance
	return nearest

func _nearest_asteroid(origin: Vector2, selection_range: float, asteroids: Array) -> Dictionary:
	var nearest := {}
	var nearest_distance := selection_range
	for item in asteroids:
		var rect: Rect2 = item["rect"]
		var closest := origin.clamp(rect.position, rect.position + rect.size)
		var distance := origin.distance_to(closest)
		if distance <= nearest_distance:
			nearest = item
			nearest_distance = distance
	return nearest

func _nearest_enemy(origin: Vector2, selection_range: float, enemies: Array):
	var nearest = null
	var nearest_distance := selection_range
	for enemy in enemies:
		if not is_instance_valid(enemy) or enemy.is_destroyed():
			continue
		var distance := origin.distance_to(enemy.position)
		if distance <= nearest_distance:
			nearest = enemy
			nearest_distance = distance
	return nearest
