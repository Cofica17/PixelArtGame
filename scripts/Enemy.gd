extends CharacterBody2D
class_name Enemy

@export var health = 20
@export var move_speed = 100
@export var attack_cooldown = 1.5
@export var damage = 5
@export var animation_frame_hit = 6

@onready var player: Player = get_tree().get_nodes_in_group("player")[0]
@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape:CollisionShape2D = $CollisionShape2D
@onready var attack_detection_area:Area2D = $AttackDetectionArea
@onready var attack_cooldown_timer:Timer = $AttackCooldownTimer

var damage_taken = 0
var dead = false

func _ready():
	attack_cooldown_timer.wait_time = attack_cooldown

func _physics_process(delta):
	if dead:
		return
	
	if not is_attacking() and not is_hit():
		move()
	if check_attack():
		attack()

func attack():
	animated_sprite.play("attack")
	attack_cooldown_timer.start()

func move():
	var dir = (player.global_position - global_position).normalized()
	velocity = dir * move_speed
	if velocity.length() != 0.0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
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
	animated_sprite.play("idle")

func check_attack():
	if is_hit():return false
	if not attack_cooldown_timer.is_stopped():return false
	
	for body in attack_detection_area.get_overlapping_bodies():
		if body is Player:
			return true
	
	return false

func check_player_hit():
	for body in attack_detection_area.get_overlapping_bodies():
		if body is Player:
			return true

func _on_animation_frame_changed():
	if not animated_sprite:
		return
	
	if is_attacking():
		if animated_sprite.frame == animation_frame_hit and check_player_hit():
			player.hit(damage)

func is_attacking():
	return animated_sprite.animation == "attack"

func is_hit():
	return animated_sprite.animation == "take_hit"
