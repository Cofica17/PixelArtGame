extends State
class_name SpellCast

var spell_1 = preload("res://spells/lightning_strike/LightningStrikes.tscn")

func enter():
	#player.play_directional_animation("idle")
	var spell = spell_1.instantiate()
	player.add_child(spell)
	spell.cast()

func process(delta):
	if player.controls.is_attacking():
		state_machine.transition_to(Attack.new())
	elif player.controls.get_movement_vector() != Vector2.ZERO:
		state_machine.transition_to(Run.new())
	else:
		state_machine.transition_to(Idle.new())

func physics_process(delta):
	pass
