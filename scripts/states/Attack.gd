extends State
class_name Attack

var combo_end = false

func enter():
	# set the current animation root state to Crouching
	player.play_mouse_directional_animation("attack1")
	player.animated_sprite.animation_finished.connect(_on_attack_animation_finished)
	player.animated_sprite.frame_changed.connect(_on_attack_animation_frame_finished)
	player.hit_area.body_entered.connect(_on_hit_area_body_entered)

func process(delta):
	pass

func physics_process(delta):
	if player.controls.is_attacking():
		player.velocity = player.controls.get_look_vector() * player.attack_step
		player.move_and_slide()

func _on_attack_animation_finished():
	if player.controls.is_attacking() and not combo_end:
		player.play_mouse_directional_animation("attack2")
		combo_end = true
	elif player.controls.is_attacking() and combo_end:
		player.play_mouse_directional_animation("attack1")
		combo_end = false
	else:
		state_machine.transition_to(Idle.new())

func _on_attack_animation_frame_finished():
	if "attack1" in player.cur_anim and player.animated_sprite.frame == 4 or\
		"attack2" in player.cur_anim and player.animated_sprite.frame == 1:
		check_hit()
	else:
		disable_hit_detection()

func disable_hit_detection():
	player.hit_area.monitoring = false

func check_hit():
	var hit_area:Area2D = player.hit_area
	hit_area.rotation = deg_to_rad(0.0)
	hit_area.transform.origin = Vector2.ZERO
	var mov_vec:Vector2 = player.controls.get_look_vector()
	hit_area.rotate(mov_vec.angle())
	hit_area.transform.origin = mov_vec * player.attack_range
	hit_area.monitoring = true

func _on_hit_area_body_entered(body):
	if body is Enemy:
		body.hit(0)
