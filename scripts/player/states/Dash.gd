extends State
class_name Dash

var DashGhost = preload("res://scenes/player/DashGhost.tscn")
var dash_ghost_spawn_timer:Timer = Timer.new()
var distance_dashed = 0.0
var last_pos = Vector3.ZERO

func enter():
	player.play_directional_animation("dash")
	player.dash_cooldown_timer.start(player.dash_cooldown)
	player.collision_shape.disabled = true
	add_child(dash_ghost_spawn_timer)
	dash_ghost_spawn_timer.timeout.connect(_dash_ghost_spawn_timer_timeout)
	dash_ghost_spawn_timer.start(0.035)
	last_pos = player.global_position

func process(delta):
	pass

func physics_process(delta):
	if distance_dashed < player.dash_distance:
		player.velocity = player.controls.get_movement_vector() * player.dash_speed
		player.move_and_slide()
		player.play_directional_animation("dash")
		distance_dashed += player.global_position.distance_to(last_pos)
		last_pos = player.global_position
	else:
		if player.controls.get_movement_vector().length() > 0:
			state_machine.transition_to(Run.new())
		else:
			state_machine.transition_to(Idle.new())

func exit():
	player.collision_shape.disabled = false

func _dash_ghost_spawn_timer_timeout():
	var anim_sprite = player.animated_sprite
	var sprite:Sprite2D = DashGhost.instantiate()
	player.add_child(sprite)
	sprite.top_level = true
	sprite.global_position = player.global_position
	sprite.texture = anim_sprite.sprite_frames.get_frame_texture(anim_sprite.animation, anim_sprite.frame)
	sprite.scale = player.scale
	sprite.flip_h = anim_sprite.flip_h
