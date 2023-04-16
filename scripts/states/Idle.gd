extends State
class_name Idle

func enter():
	# set the current animation root state to Crouching
	player.play_directional_animation("idle")

func process(delta):
	# if the jump button is pressed, transition into the InAir/Jumping state immediately
	if player.controls.is_attacking():
		state_machine.transition_to(Attack.new())
	elif player.controls.get_movement_vector() != Vector2.ZERO:
		state_machine.transition_to(Run.new())

func physics_process(delta):
	pass
#	# set the checked ground blend position to player's horizontal speed divided by 10, the running speed
#	player.anim_tree.set("parameters/OnGround/blend_position", player.horizontal_velocity.length() / $Running.move_speed)
