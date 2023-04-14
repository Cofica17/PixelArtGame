extends State
class_name Attack

func enter():
	# set the current animation root state to Crouching
	player.animated_sprite.play("attack_1")
	player.animated_sprite.animation_finished.connect(_on_attack_animation_finished)

func process(delta):
	# if the jump button is pressed, transition into the InAir/Jumping state immediately
#	if player.controls.is_attacking():
#		player.animated_sprite.play("attack_1")
	pass

func physics_process(delta):
	pass
#	# set the checked ground blend position to player's horizontal speed divided by 10, the running speed
#	player.anim_tree.set("parameters/OnGround/blend_position", player.horizontal_velocity.length() / $Running.move_speed)

func _on_attack_animation_finished():
	if player.controls.is_attacking():
		player.animated_sprite.play("attack_2")
	else:
		state_machine.transition_to(Idle.new())
