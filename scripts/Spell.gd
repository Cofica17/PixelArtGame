extends Node2D
class_name Spell

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D

func cast():
	animated_sprite.play("cast")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
