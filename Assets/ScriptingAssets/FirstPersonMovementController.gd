class_name FirstPersonMovementController
extends CharacterBody3D

## PURPOSE:
## Game-agnostic first-person walk and look controller for a CharacterBody3D body.
##
## USE WHEN:
## A project needs mouse/keyboard and gamepad locomotion plus yaw/pitch camera control.
##
## DO NOT USE WHEN:
## You need interact/inspect/menu focus flows (separate control systems) or coded collision
## layer assignment (configure layers/masks on the node and in Project Settings).
##
## OWNS:
## Move/look polling, mouse capture toggle, device-switch tracking, and camera yaw/pitch.
##
## CALLER MUST PROVIDE:
## A CollisionShape3D child, a Camera3D under CameraPivot (or assign camera_pitch_pivot),
## collision layer/mask via the inspector, and InputMap actions.
##
## GAME-SPECIFIC GLUE BELONGS:
## In player scenes, settings menus, and story/character wrappers that instance this node.

signal active_device_changed(device_name: String)

const DEVICE_MOUSE_KEYBOARD: String = "mouse_keyboard"
const DEVICE_GAMEPAD: String = "gamepad"

## Look and walk tuning resource. Created at runtime when unset.
@export var look_settings: FirstPersonLookSettings

## When true, missing move/look actions are registered with default bindings on ready.
## Prefer Project Settings -> Input Map for this game; leave false unless embedding the controller in an empty project.
@export var auto_register_missing_input_actions: bool = false

## When true, captures the mouse on ready for look input.
@export var capture_mouse_on_ready: bool = true

## InputMap action used for forward walk.
@export var move_forward_action: String = FirstPersonInputBootstrap.ACTION_MOVE_FORWARD

## InputMap action used for backward walk.
@export var move_back_action: String = FirstPersonInputBootstrap.ACTION_MOVE_BACK

## InputMap action used for left strafe.
@export var move_left_action: String = FirstPersonInputBootstrap.ACTION_MOVE_LEFT

## InputMap action used for right strafe.
@export var move_right_action: String = FirstPersonInputBootstrap.ACTION_MOVE_RIGHT

## InputMap action used for look up (gamepad).
@export var look_up_action: String = FirstPersonInputBootstrap.ACTION_LOOK_UP

## InputMap action used for look down (gamepad).
@export var look_down_action: String = FirstPersonInputBootstrap.ACTION_LOOK_DOWN

## InputMap action used for look left (gamepad).
@export var look_left_action: String = FirstPersonInputBootstrap.ACTION_LOOK_LEFT

## InputMap action used for look right (gamepad).
@export var look_right_action: String = FirstPersonInputBootstrap.ACTION_LOOK_RIGHT

## Pitch pivot that owns the Camera3D. Defaults to a child named CameraPivot.
@export var camera_pitch_pivot: Node3D

## When true, frees the mouse if the application or window loses focus (Alt-Tab safe).
@export var release_mouse_on_focus_loss: bool = true

## When true, a left-click on the game view recaptures the mouse after it was freed.
@export var recapture_mouse_on_click: bool = true

## When true, attempts to step up onto short ledges/stair lips blocked as walls.
@export var step_up_enabled: bool = true

## Maximum ledge height in meters the controller will step onto while grounded.
@export var max_step_height: float = 0.35

var _yaw_radians: float = 0.0
var _pitch_radians: float = 0.0
var _active_device: String = DEVICE_MOUSE_KEYBOARD
var _mouse_look_enabled: bool = true


func _ready() -> void:
	if look_settings == null:
		look_settings = FirstPersonLookSettings.new()
	if auto_register_missing_input_actions:
		FirstPersonInputBootstrap.ensure_default_actions()
	if camera_pitch_pivot == null:
		camera_pitch_pivot = get_node_or_null("CameraPivot") as Node3D
	if camera_pitch_pivot == null:
		push_error("FirstPersonMovementController requires a CameraPivot Node3D child or camera_pitch_pivot assignment.")
		return
	_yaw_radians = rotation.y
	_pitch_radians = camera_pitch_pivot.rotation.x
	if capture_mouse_on_ready:
		set_mouse_captured(true)


func _notification(what: int) -> void:
	if not release_mouse_on_focus_loss:
		return
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		set_mouse_captured(false)
		return
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		set_mouse_captured(false)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_button: InputEventMouseButton = event as InputEventMouseButton
		if mouse_button.pressed and mouse_button.button_index == MOUSE_BUTTON_LEFT:
			if recapture_mouse_on_click:
				if not is_mouse_captured():
					set_mouse_captured(true)
					_set_active_device(DEVICE_MOUSE_KEYBOARD)
					get_viewport().set_input_as_handled()
					return
	if event is InputEventMouseMotion:
		if not is_mouse_captured():
			return
		var mouse_motion: InputEventMouseMotion = event as InputEventMouseMotion
		_set_active_device(DEVICE_MOUSE_KEYBOARD)
		_apply_look_delta(mouse_motion.relative.x, mouse_motion.relative.y, 1.0)
		return
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		_set_active_device(DEVICE_GAMEPAD)
		return
	if event is InputEventKey:
		_set_active_device(DEVICE_MOUSE_KEYBOARD)


func _physics_process(delta: float) -> void:
	if look_settings == null:
		push_error("FirstPersonMovementController.look_settings is null.")
		return
	if camera_pitch_pivot == null:
		return
	if _active_device == DEVICE_GAMEPAD:
		_apply_gamepad_look(delta)
	var move_axes: Vector2 = _read_move_axes()
	var move_direction: Vector3 = FirstPersonMotorMath.build_planar_move_direction(
		_yaw_radians,
		move_axes.x,
		move_axes.y
	)
	var planar_velocity: Vector3 = move_direction * look_settings.walk_speed_mps
	if FirstPersonMotorMath.horizontal_speed_should_be_zero(move_axes.x, move_axes.y):
		planar_velocity = Vector3.ZERO
	velocity.x = planar_velocity.x
	velocity.z = planar_velocity.z
	if not is_on_floor():
		velocity.y -= float(ProjectSettings.get_setting("physics/3d/default_gravity")) * delta
	else:
		if velocity.y < 0.0:
			velocity.y = 0.0
	_try_step_up(delta)
	move_and_slide()
	rotation.y = _yaw_radians
	camera_pitch_pivot.rotation.x = _pitch_radians


## set_mouse_captured
## Purpose: Capture or free the mouse cursor for look input.
## Parameters: should_capture - true captures the cursor.
## Returns: void
func set_mouse_captured(should_capture: bool) -> void:
	_mouse_look_enabled = should_capture
	if should_capture:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


## toggle_mouse_capture
## Purpose: Flip mouse capture on and off for harness/debug use.
## Returns: void
func toggle_mouse_capture() -> void:
	set_mouse_captured(not _mouse_look_enabled)


## is_mouse_captured
## Purpose: Report whether look mouse capture is currently requested/active.
## Returns: true when look capture is enabled.
func is_mouse_captured() -> bool:
	return _mouse_look_enabled


## set_look_settings
## Purpose: Replace the active look/walk settings resource.
## Parameters: next_settings - Non-null settings resource.
## Returns: void
func set_look_settings(next_settings: FirstPersonLookSettings) -> void:
	if next_settings == null:
		push_error("FirstPersonMovementController.set_look_settings requires a non-null resource.")
		return
	look_settings = next_settings


## get_yaw_radians
## Purpose: Expose current body yaw for tests and harness overlays.
## Returns: Yaw in radians.
func get_yaw_radians() -> float:
	return _yaw_radians


## get_pitch_radians
## Purpose: Expose current camera pitch for tests and harness overlays.
## Returns: Pitch in radians.
func get_pitch_radians() -> float:
	return _pitch_radians


## get_active_device_name
## Purpose: Report which device currently owns control after hot-swap.
## Returns: DEVICE_MOUSE_KEYBOARD or DEVICE_GAMEPAD.
func get_active_device_name() -> String:
	return _active_device


## _read_move_axes
## Purpose: Read strafe/forward axes from the configured InputMap actions.
## Returns: Vector2(x = strafe, y = forward) in -1..1.
func _read_move_axes() -> Vector2:
	var right_axis: float = Input.get_action_strength(move_right_action) - Input.get_action_strength(move_left_action)
	var forward_axis: float = Input.get_action_strength(move_forward_action) - Input.get_action_strength(move_back_action)
	var axes: Vector2 = Vector2(right_axis, forward_axis)
	if axes.length() > 1.0:
		axes = axes.normalized()
	return axes


## _apply_gamepad_look
## Purpose: Apply right-stick look while a gamepad is the active device.
## Parameters: delta - Physics frame delta seconds.
## Returns: void
func _apply_gamepad_look(delta: float) -> void:
	var look_x: float = Input.get_action_strength(look_right_action) - Input.get_action_strength(look_left_action)
	var look_y: float = Input.get_action_strength(look_down_action) - Input.get_action_strength(look_up_action)
	if absf(look_x) <= 0.001 and absf(look_y) <= 0.001:
		return
	var scaled_x: float = look_x * look_settings.gamepad_look_scale * 60.0 * delta
	var scaled_y: float = look_y * look_settings.gamepad_look_scale * 60.0 * delta
	_apply_look_delta(scaled_x, scaled_y, 1.0)


## _apply_look_delta
## Purpose: Update yaw/pitch from a raw look delta using current settings.
## Parameters: look_x - Horizontal delta. look_y - Vertical delta. sensitivity_scale - Extra scale factor.
## Returns: void
func _apply_look_delta(look_x: float, look_y: float, sensitivity_scale: float) -> void:
	var sensitivity: float = look_settings.get_clamped_look_sensitivity() * sensitivity_scale
	var pitch_min: float = deg_to_rad(look_settings.pitch_min_degrees)
	var pitch_max: float = deg_to_rad(look_settings.pitch_max_degrees)
	var orientation: Vector2 = FirstPersonMotorMath.compute_look_orientation(
		_yaw_radians,
		_pitch_radians,
		look_x,
		look_y,
		sensitivity,
		look_settings.invert_vertical_look,
		pitch_min,
		pitch_max
	)
	_yaw_radians = orientation.x
	_pitch_radians = orientation.y


## _set_active_device
## Purpose: Record device ownership for hot-swap without requiring a restart.
## Parameters: device_name - DEVICE_MOUSE_KEYBOARD or DEVICE_GAMEPAD.
## Returns: void
func _set_active_device(device_name: String) -> void:
	if _active_device == device_name:
		return
	_active_device = device_name
	active_device_changed.emit(device_name)


## _try_step_up
## Purpose: Lift the body onto short ledges when horizontal motion is blocked by a step face.
## Parameters: delta - Physics frame delta seconds.
## Returns: void
func _try_step_up(delta: float) -> void:
	if not step_up_enabled:
		return
	if max_step_height <= 0.0:
		return
	if not is_on_floor():
		return
	var horizontal_velocity: Vector3 = Vector3(velocity.x, 0.0, velocity.z)
	if horizontal_velocity.length_squared() <= 0.0001:
		return
	var forward_motion: Vector3 = horizontal_velocity * delta
	if forward_motion.length() < 0.02:
		forward_motion = horizontal_velocity.normalized() * 0.05
	if not test_move(global_transform, forward_motion):
		return
	var up_motion: Vector3 = Vector3.UP * max_step_height
	if test_move(global_transform, up_motion):
		return
	var raised_transform: Transform3D = global_transform.translated(up_motion)
	if test_move(raised_transform, forward_motion):
		return
	var landing_collision: KinematicCollision3D = KinematicCollision3D.new()
	var raised_forward_transform: Transform3D = raised_transform.translated(forward_motion)
	var down_motion: Vector3 = Vector3.DOWN * max_step_height
	if not test_move(raised_forward_transform, down_motion, landing_collision, safe_margin):
		return
	var climbed_height: float = max_step_height + landing_collision.get_travel().y
	if climbed_height <= 0.001:
		return
	if climbed_height > max_step_height:
		return
	global_position.y += climbed_height
