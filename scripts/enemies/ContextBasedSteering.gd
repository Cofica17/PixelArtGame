extends Node2D

@export var steer_force = 0.1
@export var look_ahead = 100
@export var num_rays = 8

# context array
var ray_directions = []
var interest = []
var danger = []

var chosen_dir = Vector2.ZERO
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

func _ready():
	interest.resize(num_rays)
	danger.resize(num_rays)
	ray_directions.resize(num_rays)
	for i in num_rays:
		var angle = i * 2 * PI / num_rays
		ray_directions[i] = Vector2.RIGHT.rotated(angle)

func get_direction(cur_dir:Vector2):
	set_interest(cur_dir)
	set_danger()
	choose_direction()
	chosen_dir = cur_dir.slerp(chosen_dir, steer_force)
	return chosen_dir
	#var desired_velocity = chosen_dir.rotated(rotation) * max_speed

func set_interest(cur_dir):
	# Set interest in each slot based on world directionđ
	#if cur_dir == null:
	for i in num_rays:
		var d = ray_directions[i].dot(cur_dir)
		interest[i] = max(0, d)
		# If no world path, use default interest
	#else:
		#set_default_interest()

func set_default_interest():
	# Default to moving forward
	for i in num_rays:
		var d = ray_directions[i].dot(get_parent().transform.x)
		interest[i] = max(0, d)

func set_danger():
	# Cast rays to find danger directions
	var space_state = get_world_2d().direct_space_state
	for i in num_rays:
		var params = PhysicsRayQueryParameters2D.create(global_position,
				global_position + ray_directions[i] * look_ahead)
		params.exclude = [get_parent(), get_parent().player]
		var result = space_state.intersect_ray(params)
		#print(ray_directions[i])
		danger[i] = 1.0 if result else 0.0

func choose_direction():
	# Eliminate interest in slots with danger
	for i in num_rays:
		if danger[i] > 0.0:
			interest[i] = 0.0
	# Choose direction based on remaining interest
	chosen_dir = Vector2.ZERO
	for i in num_rays:
		chosen_dir += ray_directions[i] * interest[i]
	chosen_dir = chosen_dir.normalized()
