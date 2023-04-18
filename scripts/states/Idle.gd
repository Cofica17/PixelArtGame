extends State
class_name Idle

func enter():
	player.play_directional_animation("idle")

func process(delta):
	if player.controls.is_attacking():
		state_machine.transition_to(Attack.new())
	elif player.controls.get_movement_vector() != Vector2.ZERO:
		state_machine.transition_to(Run.new())

func physics_process(delta):
	pass
