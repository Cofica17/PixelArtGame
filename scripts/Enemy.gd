extends CharacterBody2D
class_name Enemy

@export var health = 20
@export var move_speed = 100

@onready var player: Player = get_tree().get_nodes_in_group("player")[0]
@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape:CollisionShape2D = $CollisionShape2D
@onready var attack_detection_area:Area2D = $AttackDetectionArea

var damage_taken = 0
var dead = false

func _physics_process(delta):
	move()
	check_attack()

func move():
	if dead:
		return
	
	var dir = (player.global_position - global_position).normalized()
	velocity = dir * move_speed
	move_and_slide()
	animated_sprite.flip_h = dir.x < 0

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

func check_attack():
	for body in attack_detection_area.get_overlapping_bodies():
		if body is Player:
			animated_sprite.play("attack")
