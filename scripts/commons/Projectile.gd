@tool
extends CharacterBody2D
class_name Projectile

@export var speed = 1

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D

var damage = 1
var direction = Vector2.ZERO

func _physics_process(delta):
	velocity = direction * speed
	if not is_destroy():
		if move_and_slide():
			var col:KinematicCollision2D = get_last_slide_collision()
			if col.get_collider() is Player:
				hit_player(col.get_collider())

func hit_player(player):
	player.hit(damage)
	animated_sprite.play("destroy")

func _on_animated_sprite_2d_animation_finished():
	if is_destroy():
		queue_free()

func is_destroy():
	return animated_sprite.animation == "destroy"
