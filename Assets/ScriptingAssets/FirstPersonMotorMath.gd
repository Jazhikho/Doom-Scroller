class_name FirstPersonMotorMath
extends RefCounted

## PURPOSE:
## Pure first-person move and look math with no node, input, or physics side effects.
##
## USE WHEN:
## A controller or test needs deterministic yaw-relative strafe/forward vectors and look updates.
##
## DO NOT USE WHEN:
## You need CharacterBody3D motion, collision, or InputMap polling in the same module.
##
## OWNS:
## Stateless math helpers only.
##
## CALLER MUST PROVIDE:
## Current yaw/pitch, raw move axes, look deltas, and sensitivity/invert/pitch limits.
##
## GAME-SPECIFIC GLUE BELONGS:
## In scene controllers that read Input and apply velocity to a body.


## build_planar_move_direction
## Purpose: Build a normalized planar move direction from yaw and WASD-style axes.
## Parameters: yaw_radians - Body yaw around world up. move_right_axis - Strafe axis (-1 left, +1 right). move_forward_axis - Forward axis (-1 back, +1 forward).
## Returns: Normalized Vector3 on the XZ plane, or Vector3.ZERO when input is released.
static func build_planar_move_direction(yaw_radians: float, move_right_axis: float, move_forward_axis: float) -> Vector3:
	var yaw_basis: Basis = Basis(Vector3.UP, yaw_radians)
	var forward: Vector3 = - yaw_basis.z
	var right: Vector3 = yaw_basis.x
	var combined: Vector3 = (right * move_right_axis) + (forward * move_forward_axis)
	combined.y = 0.0
	if combined.length_squared() <= 0.000001:
		return Vector3.ZERO
	return combined.normalized()


## compute_look_orientation
## Purpose: Apply look deltas with sensitivity, optional Y invert, and pitch clamps.
## Parameters: yaw_radians - Current yaw. pitch_radians - Current pitch. look_x - Raw horizontal look delta. look_y - Raw vertical look delta. sensitivity - Look rate. invert_vertical_look - When true, flips vertical delta. pitch_min_radians - Minimum pitch. pitch_max_radians - Maximum pitch.
## Returns: Vector2 where x is new yaw radians and y is new pitch radians.
static func compute_look_orientation(
	yaw_radians: float,
	pitch_radians: float,
	look_x: float,
	look_y: float,
	sensitivity: float,
	invert_vertical_look: bool,
	pitch_min_radians: float,
	pitch_max_radians: float
) -> Vector2:
	if sensitivity <= 0.0:
		push_error("FirstPersonMotorMath.compute_look_orientation requires sensitivity greater than 0.")
		return Vector2(yaw_radians, pitch_radians)
	var vertical_delta: float = look_y
	if invert_vertical_look:
		vertical_delta = - look_y
	# Non-inverted matches standard Godot FPS: pitch -= mouse delta.
	# Mouse up (negative look_y) increases pitch; mouse down decreases it.
	var next_yaw: float = yaw_radians - (look_x * sensitivity)
	var next_pitch: float = pitch_radians - (vertical_delta * sensitivity)
	next_pitch = clampf(next_pitch, pitch_min_radians, pitch_max_radians)
	return Vector2(next_yaw, next_pitch)


## horizontal_speed_should_be_zero
## Purpose: Report whether released move axes should force a full planar stop.
## Parameters: move_right_axis - Strafe axis. move_forward_axis - Forward axis.
## Returns: true when both axes are effectively zero.
static func horizontal_speed_should_be_zero(move_right_axis: float, move_forward_axis: float) -> bool:
	if absf(move_right_axis) > 0.000001:
		return false
	if absf(move_forward_axis) > 0.000001:
		return false
	return true
