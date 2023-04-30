extends Node2D
class_name Spell

@onready var player:Player = get_tree().get_nodes_in_group("player")[0]
@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var area:Area2D = $Area2D

@export var cooldown = 1.0

var casted = false
var cooldown_timer:Timer = Timer.new()

func _ready():
	top_level = true
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)

func cast():
	animated_sprite.play("cast")
	casted = true

func can_cast():
	return cooldown_timer.is_stopped()

func _on_animated_sprite_2d_animation_finished():
	destroy()

func destroy():
	queue_free()
