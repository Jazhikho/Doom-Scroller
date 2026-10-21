class_name FirstPersonLookSettings
extends Resource

## PURPOSE:
## Tunable look and walk values for a first-person movement controller.
##
## USE WHEN:
## A project needs designer-editable sensitivity, invert-Y, pitch limits, and walk speed
## without hardcoding those values into the controller script.
##
## OWNS:
## Sensitivity bounds, invert flag, pitch clamp degrees, and walk speed.
##
## CALLER MUST PROVIDE:
## Application of these values to a FirstPersonMovementController (assign or call apply APIs).

## Horizontal and vertical look rate in radians per mouse pixel (also scales gamepad look).
@export var look_sensitivity: float = 0.0025

## Lowest allowed look sensitivity. Must stay above zero so look cannot be disabled by the slider.
@export var look_sensitivity_min: float = 0.0008

## Highest allowed look sensitivity.
@export var look_sensitivity_max: float = 0.012

## When true, vertical look input is flipped relative to the labeled non-inverted default.
@export var invert_vertical_look: bool = false

## Minimum camera pitch in degrees (negative looks down with the default pivot setup).
@export var pitch_min_degrees: float = -85.0

## Maximum camera pitch in degrees (positive looks up with the default pivot setup).
@export var pitch_max_degrees: float = 85.0

## Planar walk speed in meters per second.
@export var walk_speed_mps: float = 3.5

## Extra scale applied only to gamepad look axes (compensates for lower mouse radian scale).
@export var gamepad_look_scale: float = 30.0


## clamp_look_sensitivity
## Purpose: Keep sensitivity inside the configured min/max band without allowing a zero rate.
## Parameters: requested_sensitivity - Desired look sensitivity before clamping.
## Returns: Sensitivity safe for look input.
func clamp_look_sensitivity(requested_sensitivity: float) -> float:
	var minimum_rate: float = look_sensitivity_min
	if minimum_rate <= 0.0:
		push_error("FirstPersonLookSettings.look_sensitivity_min must be greater than 0.")
		minimum_rate = 0.0008
	var maximum_rate: float = look_sensitivity_max
	if maximum_rate < minimum_rate:
		push_error("FirstPersonLookSettings.look_sensitivity_max must be >= look_sensitivity_min.")
		maximum_rate = minimum_rate
	return clampf(requested_sensitivity, minimum_rate, maximum_rate)


## get_clamped_look_sensitivity
## Purpose: Return the resource's current sensitivity after bounds clamping.
## Returns: Clamped look sensitivity.
func get_clamped_look_sensitivity() -> float:
	return clamp_look_sensitivity(look_sensitivity)


## set_look_sensitivity
## Purpose: Assign sensitivity and immediately clamp it into the valid range.
## Parameters: requested_sensitivity - Desired look sensitivity before clamping.
## Returns: void
func set_look_sensitivity(requested_sensitivity: float) -> void:
	look_sensitivity = clamp_look_sensitivity(requested_sensitivity)
