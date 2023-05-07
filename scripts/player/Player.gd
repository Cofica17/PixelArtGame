extends CharacterBody2D
class_name Player
#needs a parent script that will be shared with Enemy script, called CombatEntity

@export var invincible = false
@export var health = 20
@export var move_speed = 100
@export var attack_step = 5
@export var attack_range = 15
@export var damage = 10
@export var critical_chance = 0.15
@export var critical_damage = 2
@export var dash_distance = 250
@export var dash_cooldown = 0.8
@export var dash_speed = 500

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_area:Area2D = $HitArea
@onready var dash_cooldown_timer:Timer = $DashCooldownTimer
@onready var collision_shape:CollisionShape2D = $CollisionShape2D

var state_machine = StateMachine.new()
var controls = Controls.new()
var cur_anim = "idle"

func _ready():
	add_to_group("player")
	add_child(controls)
	add_child(state_machine)

func _process(delta):
	state_machine._process(delta)

func _physics_process(delta):
	state_machine._physics_process(delta)

func hit(damage):
	if invincible:
		return
	
	health = max(health-damage, 0.0)
	if health == 0:
		death()
		return
	
	var tween = get_tree().create_tween()
	tween.tween_method(apply_flash, 1.0, 0.0, 0.35).set_trans(Tween.TRANS_SINE)

func death():
	state_machine.transition_to(Death.new())

func apply_flash(flash):
	animated_sprite.material.set_shader_parameter("flash", flash)

func add_item(item_id, amount):
	pass

func play_animation(anim):
	animated_sprite.play(anim)

func play_mouse_directional_animation(anim):
	animated_sprite.play_mouse_directional_animation(anim)

func play_directional_animation(anim):
	animated_sprite.play_directional_animation(anim)

func get_can_dash():
	return dash_cooldown_timer.is_stopped()

func get_is_critical():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(0.0, 1.0)
	return my_random_number <= critical_chance

func get_can_cast_spell():
	return true
