extends State
class_name Idle

func enter():
	player.play_directional_animation("idle")

func process(delta):
	if player.controls.is_attacking():
		state_machine.transition_to(Attack.new())
	elif player.controls.get_movement_vector() != Vector2.ZERO:
		state_machine.transition_to(Run.new())
	elif player.controls.is_casting_spell_1():
		state_machine.transition_to(SpellCast.new())

func physics_process(delta):
	pass
