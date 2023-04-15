extends CharacterBody2D
class_name Player

@export var run_speed = 100

@onready var animated_sprite = $AnimatedSprite2D

var state_machine = StateMachine.new()
var controls = Controls.new()

func _ready():
	add_child(controls)
	add_child(state_machine)

func _process(delta):
	state_machine._process(delta)
	print(controls.get_movement_vector())

func _physics_process(delta):
	state_machine._physics_process(delta)

func play_animation(anim):
	animated_sprite.play(anim)

func play_directional_animation(anim):
	var mov_vec = controls.get_movement_vector()
	var postfix = ""
	var mirror = false
	if mov_vec.x != 0 and mov_vec.y < 0:
		postfix = "_backside"
		if mov_vec.x < 0:
			mirror = true
	elif mov_vec.x != 0 and mov_vec.y > 0:
		postfix = "_frontside"
		if mov_vec.x < 0:
			mirror = true
	elif mov_vec.x > 0 or mov_vec.x < 0:
		postfix = "_side"
		if mov_vec.x < 0:
			mirror = true
	elif mov_vec.y > 0:
		postfix = "_front"
	elif mov_vec.y < 0:
		postfix = "_back"
	animated_sprite.play(anim+postfix)
	animated_sprite.flip_h = mirror
