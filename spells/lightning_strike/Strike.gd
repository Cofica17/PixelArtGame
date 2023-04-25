extends Node2D

var follow_pos

func _physics_process(delta):
	if follow_pos:
		global_position = follow_pos

func _on_animated_sprite_2d_animation_finished():
	queue_free()
