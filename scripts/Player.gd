extends CharacterBody2D
class_name Player

@onready var animated_sprite = $AnimatedSprite2D

var state_machine = StateMachine.new()
var controls = Controls.new()

func _ready():
	add_child(controls)
	add_child(state_machine)

func _process(delta):
	state_machine._process(delta)

func _physics_process(delta):
	state_machine._physics_process(delta)
