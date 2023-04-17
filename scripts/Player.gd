extends CharacterBody2D
class_name Player

@export var run_speed = 100
@export var attack_step = 5
@export var attack_range = 15

@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_area:Area2D = $HitArea

var state_machine = StateMachine.new()
var controls = Controls.new()
var cur_anim = "idle"

func _ready():
	add_child(controls)
	add_child(state_machine)

func _process(delta):
	state_machine._process(delta)

func _physics_process(delta):
	state_machine._physics_process(delta)

func play_animation(anim):
	animated_sprite.play(anim)

func play_mouse_directional_animation(anim):
	var look_vec = controls.get_look_vector()
	
	var postfix = _get_directional_animation_postfix(look_vec)
	var mirror = _get_directional_animation_flip_h(look_vec)
	
	animated_sprite.play(anim+postfix)
	animated_sprite.flip_h = mirror

func play_directional_animation(anim):
	var mov_vec = controls.get_movement_vector()
	
	if anim == "idle" or anim == "attack1" or anim == "attack2":
		mov_vec = controls.get_last_directional_movement_vector()
	
	var postfix = _get_directional_animation_postfix(mov_vec)
	var mirror = _get_directional_animation_flip_h(mov_vec)
	
	animated_sprite.play(anim+postfix)
	animated_sprite.flip_h = mirror

func _get_directional_animation_postfix(mov_vec):
	var postfix = "_side"
	if mov_vec.x != 0 and mov_vec.y < 0:
		postfix = "_backside"
	elif mov_vec.x != 0 and mov_vec.y > 0:
		postfix = "_frontside"
	elif mov_vec.x > 0 or mov_vec.x < 0:
		postfix = "_side"
	elif mov_vec.y > 0:
		postfix = "_front"
	elif mov_vec.y < 0:
		postfix = "_back"
	return postfix

func _get_directional_animation_flip_h(mov_vec):
	return mov_vec.x < 0

func _on_animated_sprite_2d_animation_changed():
	if not animated_sprite:
		return
	
	cur_anim = animated_sprite.animation
