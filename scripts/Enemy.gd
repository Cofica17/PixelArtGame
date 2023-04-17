extends CharacterBody2D
class_name Enemy

@export var health = 20

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape:CollisionShape2D = $CollisionShape2D

var damage_taken = 0
var dead = false

func hit(damage):
	animated_sprite.play("take_hit")
	animated_sprite.frame = 0
	damage_taken += damage
	if damage_taken >= health:
		die()

func die():
	animated_sprite.play("death")
	animated_sprite.disconnect("animation_finished", _on_animated_sprite_2d_animation_finished)
	collision_shape.set_deferred("disabled", true)
	dead = true

func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("fly")
