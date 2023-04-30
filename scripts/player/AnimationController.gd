extends AnimatedSprite2D

@onready var player: Player = get_tree().get_nodes_in_group("player")[0]

func _on_animation_changed():
	player.cur_anim = animation

func play_mouse_directional_animation(anim):
	var look_vec = player.controls.get_look_vector()
	
	var postfix = _get_directional_animation_postfix(look_vec)
	var mirror = _get_directional_animation_flip_h(look_vec)
	
	play(anim+postfix)
	flip_h = mirror

func play_directional_animation(anim):
	var mov_vec = player.controls.get_movement_vector()
	
	if anim == "idle" or anim == "attack1" or anim == "attack2":
		mov_vec = player.controls.get_last_directional_movement_vector()
	
	var postfix = _get_directional_animation_postfix(mov_vec)
	var mirror = _get_directional_animation_flip_h(mov_vec)
	
	play(anim+postfix)
	flip_h = mirror

func _get_directional_animation_postfix(mov_vec):
	var postfix = "_side"
	if mov_vec.x != 0 and mov_vec.y < 0:
		postfix = "_backside"
	elif mov_vec.x != 0 and mov_vec.y > 0:
		postfix = "_frontside"
	elif mov_vec.x > 0 or mov_vec.x < 0:
		postfix = "_side"
	elif mov_vec.y > 0:
		postfix = "_front"
	elif mov_vec.y < 0:
		postfix = "_back"
	return postfix

func _get_directional_animation_flip_h(mov_vec):
	return mov_vec.x < 0
