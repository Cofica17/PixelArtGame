extends State
class_name Attack

var combo_end = false

func enter():
	# set the current animation root state to Crouching
	player.animated_sprite.play("attack_1")
	player.animated_sprite.animation_finished.connect(_on_attack_animation_finished)

func process(delta):
	# if the jump button is pressed, transition into the InAir/Jumping state immediately
	pass

func physics_process(delta):
	pass

func _on_attack_animation_finished():
	if player.controls.is_attacking() and not combo_end:
		player.animated_sprite.play("attack_2")
		combo_end = true
	elif player.controls.is_attacking() and combo_end:
		player.animated_sprite.play("attack_1")
		combo_end = false
	else:
		state_machine.transition_to(Idle.new())
