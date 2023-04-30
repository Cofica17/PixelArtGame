extends AnimatedSprite2D

@onready var player: Player = get_tree().get_nodes_in_group("player")[0]

func _on_animation_changed():
	player.cur_anim = animation
