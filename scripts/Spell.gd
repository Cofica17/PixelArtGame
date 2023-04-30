extends Node2D
class_name Spell

@onready var player:Player = get_tree().get_nodes_in_group("player")[0]
@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var area:Area2D = $Area2D

func _ready():
	top_level = true

func cast():
	animated_sprite.play("cast")

func _on_animated_sprite_2d_animation_finished():
	destroy()

func destroy():
	queue_free()
