extends CharacterBody2D
class_name Enemy

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D

func hit(damage):
	animated_sprite.play("take_hit")
	animated_sprite.frame = 0

func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("fly")
