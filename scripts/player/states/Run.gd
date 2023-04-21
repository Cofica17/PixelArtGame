extends State
class_name Run

func enter():
	player.play_directional_animation("run")

func process(delta):
	if player.controls.is_attacking():
		state_machine.transition_to(Attack.new())
	elif player.controls.get_movement_vector().length() == 0:
		state_machine.transition_to(Idle.new())
	elif player.controls.is_dashing() and player.get_can_dash():
		state_machine.transition_to(Dash.new())
	else:
		player.play_directional_animation("run")

func physics_process(delta):
	var mov_vec = player.controls.get_movement_vector()
	var run_speed = player.move_speed
	player.velocity = mov_vec * run_speed
	player.move_and_slide()
